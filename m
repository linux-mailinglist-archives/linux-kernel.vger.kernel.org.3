Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A35528300
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243013AbiEPLSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243044AbiEPLSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:18:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D19340DB
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 04:18:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id z2so27978498ejj.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 04:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pmfsIHbJLueJ35bgeNRJJDeDJTrJmP4/XqfMWtgXDDU=;
        b=LYQ5GtiwSVm7LNB+PreZgfk443WWrmBicaCw3pTCFbG34FCjiXhosbAYFm87ix7mRR
         DJbuykytG5jHe5EG6osBFZxVeuf8Z9hE8BDt9SzTkRybx6abf40mMW5G+xJSRv/p/a1f
         qTRa7keeTPtp1GGGOXHQM8N0eQoLXj7ea7UHeT88fG/iZdc4Xg9jPafY821hsfF0XHEy
         zJoRgyRZjzvJpPyk/BgrDPkinijKPpOc1RW0z0SVAEEADPXcaVQInavPQMoLhiRkc7Qu
         2Crt2OFfk1vkgIzdYsOgdea//NZRgRHX6lwxGlINBvHBd7IctLjbcdlueThFG4D5/uMU
         o+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pmfsIHbJLueJ35bgeNRJJDeDJTrJmP4/XqfMWtgXDDU=;
        b=egFot1TMcgpCAUwbqy0F5oYCf/Rk27oeyWWVWDjl1x5aweU7oX2tQlZ53VnTvzy0s5
         Kvn3xV10aWyRa6oSfNvV/9hunzsWNrtG4Sev5QGgabohXwBEonNZmKK92ddutd9NopgC
         xlPfQtr9MO39iS85FH7IlNC5ELYoTOYkL2EYnjgpspMJO5RJct2TUSFnfcurImv1BBpd
         gs8fweCcPObvxBfa4GG2IDhzMHuVpBiGzqZfentjo3YQ+1ii4KT9EkLIzfX+8ZH8QnIX
         hjHjgIIPgESg0/LLDJWMcg29a0/Vp8fH73mMTRvl4nidRNQ6nH1W0WMumbm8OX4RLUjN
         De4Q==
X-Gm-Message-State: AOAM532oAmfuOCeMO/K6g+mCsY6guY8y8M0p+b5lCe3IZWDHXFAZzN1h
        eGJnky8Nm7yR5m+FiuVqz7Zw/mp8YLeNrxp9Ds8=
X-Google-Smtp-Source: ABdhPJwgrDSEMVCmTZL7/2CDNe+hDmsyDMJ6mbkGGNi7nbYA9oDjQdMYkNNbKIpX/huxznQlvqJnWRbR8UjgvHonpTk=
X-Received: by 2002:a17:907:7b9f:b0:6f4:d8c5:392c with SMTP id
 ne31-20020a1709077b9f00b006f4d8c5392cmr14484077ejc.652.1652699928032; Mon, 16
 May 2022 04:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <1652688372-10274-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1652688372-10274-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 16 May 2022 08:18:38 -0300
Message-ID: <CAOMZO5DB9xNfdqffk6k8vLaC6efvGPtUx7NaA5AF1BYL37yaOw@mail.gmail.com>
Subject: Re: [PATCH 0/3] ASoC: fsl_sai: Add support for i.MX8MM, MP, ULP
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Mon, May 16, 2022 at 5:18 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> ASoC: fsl_sai: Add support for i.MX8MM, MP, ULP platforms
>
> Shengjiu Wang (3):
>   ASoC: fsl_sai: Add support for i.MX8MM
>   ASoC: fsl_sai: Add support for i.MX8M Plus
>   ASoC: fsl_sai: Add support for i.MX8ULP

For the series:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
