Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D2D597B45
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242514AbiHRCBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiHRCAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:00:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35840A1D7F;
        Wed, 17 Aug 2022 19:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660788055; x=1692324055;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=z9f2rdVB1vY/BpOARRMLNeVHWq/YBicr3kYm4TzriQ4=;
  b=ZrBC6RGkjDElv8t9Y15ioKIn3oajgRL0OHLYrE8s7zv/gic7Lzi5mlOl
   Za2LXzm8pXC0sBoGJOu7xU9eQwhlUiZYCbC0qI7csgbm2e2c4dNfdBP4I
   8CfecRxPU+/cPSKPyMu96kZLh/SMdUQm9zR1rMvLiZEbjBKHIHmP1rt28
   lt+/Zw932PkcF7qc9G6+cp8xn2s5Hm+sNg3aTHgobsWGJLhJdW3NA2Y9h
   rqLpr335dhD8DtmX2BSvIJOlaHxLrrFCQUGuuTXiwRoLgPAifMYOEkqjs
   +jsKu4B3P8YtD2khNqfiEN9Mb53f21+CkY7ksZYiVHlXVzZBa6JIFkwTV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="273035806"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="273035806"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 19:00:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="696990692"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2022 19:00:53 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOUq5-0001bS-07;
        Thu, 18 Aug 2022 02:00:53 +0000
Date:   Thu, 18 Aug 2022 09:59:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-doc@vger.kernel.org
Subject: [krzk-mem-ctrl:for-v6.1/brcm-stb 1/3] htmldocs: Warning:
 Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt references a file
 that doesn't exist:
 Documentation/devicetree/bindings/memory-controllers/brcm,memc.yaml
Message-ID: <202208180941.oGoLuq8U-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git for-v6.1/brcm-stb
head:   65991a63d02decf269e7d5334620df0dd5919762
commit: 0da0b6bf854dcfb047fec70bbbadabb7ff0fcb3e [1/3] dt-bindings: memory-controller: Document Broadcom STB MEMC
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Warning: Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt references a file that doesn't exist: Documentation/devicetree/bindings/memory-controllers/brcm,memc.yaml

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
