Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB0654018A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbiFGOfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbiFGOfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:35:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6420C647E;
        Tue,  7 Jun 2022 07:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654612549; x=1686148549;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Rcg+NasEe8/3X7t7oVPT1nlH+/sLl3ybJIeFpVDXsK8=;
  b=gzCRyy/nTscfYFZo+hsgLm0YpElwr5l9/ZLgRdpLF7UjJ9dyNBYuPK9E
   QMhuRDjyW611TS2Jy85kKMsIzahZBCf343SPpN+4+m8Hvo7ljG5A7lVz3
   62Dk43L0Bln9XENPHGS3F9KESYR4eBLlBQ6LQOmjB+xFHG+glvrC8TEXW
   SMlmMJjqwsAUh+SYkWveycLA+7cLtQodUhoyc/7+aSCFjc6ZOEFAZJAZ6
   jzowXniapVyQ9FDEJDweG5B65HqYl4ajOCh65hFy6HUyWXm9eoGa4Aiw0
   jkK9Kx/8Sawhi+geRX/GCAtVUvpKfn3PKDHPFyOpBXvg+H3jQGPqsB64y
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277543282"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="277543282"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 07:30:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="636147593"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 07:30:23 -0700
Date:   Tue, 7 Jun 2022 17:30:21 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/36] tty/vt: consolemap: extract dict unsharing to
 con_unshare_unimap()
In-Reply-To: <20220607104946.18710-19-jslaby@suse.cz>
Message-ID: <c88ceb53-6039-8ea4-d8d9-d5f225b4ef68@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-19-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1491044709-1654612224=:1622"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1491044709-1654612224=:1622
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> The code in con_set_unimap() is too nested. Extract its obvious part
> into a separate function and name it after what the code does:
> con_unshare_unimap().
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1491044709-1654612224=:1622--
