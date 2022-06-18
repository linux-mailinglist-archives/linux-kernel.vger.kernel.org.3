Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5240C550760
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 00:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiFRWtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 18:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiFRWtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 18:49:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A171CE0BC
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 15:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :Cc:Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9uVMbhApZ0Mp+uHyuGaV5a384mogiHoFmbvbVDjUQR4=; b=jgnwz6ic5j3QKWJvttvfVbZbe0
        +Pd3auhSnl9cDI6Z8D2ITvZ8QlwcXo+SII4YxFayFDZE4480VKlCW8ZjMkkE6Wefug1UOimdcWKnd
        i24+5ukj7T/ZcxKjBpBWihZUEBm2zuWNaw0QzjjNwX7JFx6bY0H4Uw4Ziw3GW1AledMCWSWgb0C7P
        vWZCed46kdE7UEsjY1ZPcN4/QNiy4+YFVWoqnb3MNCO9pY36IWWNKbGuZp6l33w+nXAZnEGG27Xy/
        Rgr1ZDjqje5grFmRecYtgmUusNtKm3dSEM7vBMl3rD/RPtHvbIK0xPaD8ictJlcKc13dVmbhJ3ZO+
        t+o+GPpA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2hG6-00930S-Jf; Sat, 18 Jun 2022 22:49:39 +0000
Message-ID: <9a0ed0bb-34c7-bacb-16a8-fdb158535ab2@infradead.org>
Date:   Sat, 18 Jun 2022 15:49:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [DRM/hisilicon/hibmc] kernel robot reports build errors, patch(es)
 available but not merged
Cc:     RongrongZou <zourongrong@huawei.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        John Stultz <jstultz@google.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


kernel robot reports today:

* riscv64-linux-ld: ttm_bo_vm.c:undefined reference to `vmf_insert_pfn_prot'
  https://lore.kernel.org/lkml/202206190651.smtms3Ay-lkp@intel.com/T/#u

* ttm_bo_vm.c:undefined reference to `vmf_insert_pfn_prot'
  https://lore.kernel.org/lkml/202206190523.0Ar6yQF7-lkp@intel.com/T/#u


and earlier:

* ld.lld: error: undefined symbol: vmf_insert_pfn_prot
https://lore.kernel.org/lkml/202203281125.Jp08egXu-lkp@intel.com/

* ttm_bo_vm.c:undefined reference to `vmf_insert_pfn_prot'
https://lore.kernel.org/lkml/202204081648.gV63Gt0t-lkp@intel.com/


I sent a patch for this on 2022-04-08 and again on 2022-05-30 (UTC).

https://lore.kernel.org/all/20220409030504.16089-1-rdunlap@infradead.org/
https://lore.kernel.org/all/20220531025557.29593-1-rdunlap@infradead.org/

Neither one has been applied or even had a comment.  :(

-- 
~Randy
