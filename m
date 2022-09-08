Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE13C5B1DBA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiIHM4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiIHM4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:56:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FCD8E44C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mo6NlbP81uv17J7rxsGK8qsFkgGcB1sLT6G0zNwoAOA=;
        t=1662641774; x=1663851374; b=lZ4PHophL5MUpWK9DMHgt8HKpDpSeaglkMlSvgoaxPt/tiG
        QE9R+Vs76mCJGoJrzCmXeQuerjZQbAR/NE5Y+JAKzQ4fYPVB4vM2gyaqfgywnmB2tSy45L9ADwQVo
        qFPV5ufFD1uvpYUPpBvRoW6z332bFX3PiaQ35U9vZp+NfjYdijy/DVwZm39sN2VM83zWqmzc6Mu2v
        EccRsWSUu4Dp9U/l5m3lfJOm5mS1V/ilqU2/v9DftW+VTgA30wenDPOIaliBk5P6GUnU55jxuIA8s
        hwR+RQxeQlo8Tkunp5whhLnTipVe+FTiuBI7VYVu4Dhkc/mYP1gWDfYAWDNfTZMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oWH4f-00BBha-0C;
        Thu, 08 Sep 2022 14:56:05 +0200
Message-ID: <514c7366cc8e78face3094a66bb2c4bf030f9432.camel@sipsolutions.net>
Subject: Re: [PATCH] um/kernel: fix repeated words in comments
From:   Johannes Berg <johannes@sipsolutions.net>
To:     wangjianli <wangjianli@cdjrlc.com>, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Sep 2022 14:56:03 +0200
In-Reply-To: <20220908125401.28130-1-wangjianli@cdjrlc.com>
References: <20220908125401.28130-1-wangjianli@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-08 at 20:54 +0800, wangjianli wrote:
> Delete the redundant word 'in'.
>=20
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  arch/um/kernel/physmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
> index e7c7b53a1435..91485119ae67 100644
> --- a/arch/um/kernel/physmem.c
> +++ b/arch/um/kernel/physmem.c
> @@ -169,7 +169,7 @@ __uml_setup("iomem=3D", parse_iomem,
>  );
> =20
>  /*
> - * This list is constructed in parse_iomem and addresses filled in in
> + * This list is constructed in parse_iomem and addresses filled in
>   * setup_iomem, both of which run during early boot.  Afterwards, it's
>=20
Fine, I guess, but honestly - that sentence doesn't parse well either
way. Might be worth addressing that at the same time...

johannes
