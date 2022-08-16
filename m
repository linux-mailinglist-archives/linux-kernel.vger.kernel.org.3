Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA0C595786
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiHPKHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiHPKHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:07:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA01975399;
        Tue, 16 Aug 2022 01:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660639451; x=1692175451;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=utA9ZYYdfIzqRA7D5VhDGQl155B+SJSPa8zrvZsBoyo=;
  b=W3X4oA0n//X/JB6no7U5QVmmgcnB9EciEP7whI6w4+mH+vP+pYS4yy91
   5Ny1jQHp/KyxH2YDkOOlj3aAt6ByvbGRMlUs0NjZCbeXuUf7SgNggjml/
   0DtrILzcxt1amq5eCaPsRG+U1bZ3svNhYt8THAYmZShzFYxB4L5STbtNR
   q1OpoL03owXC43jmeyqq4hdRRilt6u86sQwIuGFBXnajam59tsWb2IXRb
   BxBCHx7kjasZkkwOJ3MPf6mfgQbGY3ntAcfK/f1yUVheMRqjj/UrvBFQs
   +FnCI3PQw4sxzYw3q8av1losN9oSviw1IRMC6K5Vn0RZXnIxwYouilgR8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="292161431"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="292161431"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 01:44:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="667018321"
Received: from rongch2-desk.sh.intel.com (HELO localhost) ([10.239.159.175])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 01:44:09 -0700
Date:   Tue, 16 Aug 2022 16:44:07 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Borislav Petkov <bp@suse.de>,
        linux-doc@vger.kernel.org
Subject: [tip:x86/microcode 1/2] htmldocs:
 Documentation/admin-guide/tainted-kernels.rst:143: WARNING: Block quote ends
 without a blank line; unexpected unindent.
Message-ID: <YvtY15K5lzCW9EmI@rongch2-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
head:   71da8a554f25713964a919311c324e5a32f08239
commit: 35da8ad78e9b1a25d95a281966c439da1ef9a98a [1/2] x86/microcode: Document the whole late loading problem
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/admin-guide/tainted-kernels.rst:143: WARNING: Block quote ends without a blank line; unexpected unindent.

vim +143 Documentation/admin-guide/tainted-kernels.rst

896dd323abbf6a Thorsten Leemhuis         2019-01-08  111  
896dd323abbf6a Thorsten Leemhuis         2019-01-08  112   0)  ``G`` if all modules loaded have a GPL or compatible license, ``P`` if
337c188dff4a85 Mauro Carvalho Chehab     2016-11-07  113       any proprietary module has been loaded.  Modules without a
337c188dff4a85 Mauro Carvalho Chehab     2016-11-07  114       MODULE_LICENSE or with a MODULE_LICENSE that is not recognised by
337c188dff4a85 Mauro Carvalho Chehab     2016-11-07  115       insmod as GPL compatible are assumed to be proprietary.
337c188dff4a85 Mauro Carvalho Chehab     2016-11-07  116  
896dd323abbf6a Thorsten Leemhuis         2019-01-08  117   1)  ``F`` if any module was force loaded by ``insmod -f``, ``' '`` if all
337c188dff4a85 Mauro Carvalho Chehab     2016-11-07  118       modules were loaded normally.
337c188dff4a85 Mauro Carvalho Chehab     2016-11-07  119  
547f574fd9d5e3 Mathieu Chouquet-Stringer 2020-12-02  120   2)  ``S`` if the kernel is running on a processor or system that is out of
547f574fd9d5e3 Mathieu Chouquet-Stringer 2020-12-02  121       specification: hardware has been put into an unsupported configuration,
547f574fd9d5e3 Mathieu Chouquet-Stringer 2020-12-02  122       therefore proper execution cannot be guaranteed.
547f574fd9d5e3 Mathieu Chouquet-Stringer 2020-12-02  123       Kernel will be tainted if, for example:
547f574fd9d5e3 Mathieu Chouquet-Stringer 2020-12-02  124  
547f574fd9d5e3 Mathieu Chouquet-Stringer 2020-12-02  125       - on x86: PAE is forced through forcepae on intel CPUs (such as Pentium M)
547f574fd9d5e3 Mathieu Chouquet-Stringer 2020-12-02  126         which do not report PAE but may have a functional implementation, an SMP
547f574fd9d5e3 Mathieu Chouquet-Stringer 2020-12-02  127         kernel is running on non officially capable SMP Athlon CPUs, MSRs are
547f574fd9d5e3 Mathieu Chouquet-Stringer 2020-12-02  128         being poked at from userspace.
547f574fd9d5e3 Mathieu Chouquet-Stringer 2020-12-02  129       - on arm: kernel running on certain CPUs (such as Keystone 2) without
547f574fd9d5e3 Mathieu Chouquet-Stringer 2020-12-02  130         having certain kernel features enabled.
547f574fd9d5e3 Mathieu Chouquet-Stringer 2020-12-02  131       - on arm64: there are mismatched hardware features between CPUs, the
547f574fd9d5e3 Mathieu Chouquet-Stringer 2020-12-02  132         bootloader has booted CPUs in different modes.
547f574fd9d5e3 Mathieu Chouquet-Stringer 2020-12-02  133       - certain drivers are being used on non supported architectures (such as
547f574fd9d5e3 Mathieu Chouquet-Stringer 2020-12-02  134         scsi/snic on something else than x86_64, scsi/ips on non
547f574fd9d5e3 Mathieu Chouquet-Stringer 2020-12-02  135         x86/x86_64/itanium, have broken firmware settings for the
547f574fd9d5e3 Mathieu Chouquet-Stringer 2020-12-02  136         irqchip/irq-gic on arm64 ...).
35da8ad78e9b1a Ashok Raj                 2022-08-13  137       - x86/x86_64: Microcode late loading is dangerous and will result in
35da8ad78e9b1a Ashok Raj                 2022-08-13  138         tainting the kernel. It requires that all CPUs rendezvous to make sure
35da8ad78e9b1a Ashok Raj                 2022-08-13  139         the update happens when the system is as quiescent as possible. However,
35da8ad78e9b1a Ashok Raj                 2022-08-13  140         a higher priority MCE/SMI/NMI can move control flow away from that
35da8ad78e9b1a Ashok Raj                 2022-08-13  141         rendezvous and interrupt the update, which can be detrimental to the
35da8ad78e9b1a Ashok Raj                 2022-08-13  142         machine.
35da8ad78e9b1a Ashok Raj                 2022-08-13 @143  e

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

