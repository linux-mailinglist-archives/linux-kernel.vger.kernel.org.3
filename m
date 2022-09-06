Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8105AE6C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiIFLmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiIFLmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:42:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2E733401
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 04:42:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so7260802wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 04:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yfwusrA/vHTen2gLyGVSqF1Zuxr8iDP38xL+HIoCxPI=;
        b=QkM9zo9PN2dWAiC8J4q0THRsOuX24X/0IhqXiSTaZbCTClt+1QWxnekXzhtV7mEEFC
         J9ChK+JMTerYRrKuh8XoBouBuTylZMvgrtfQtzBcGjITn4BG6SvU3D15LBV3Db2pZ8g5
         JdCmBntAE0+4+tMGV7VIz1kJ8B5+kc9UW0b/xdDxGItoeLNpy8iu8WOejf7WtyNVa4Oa
         go4po6ri4qntg4X1g6oAueCnUd/Oa5vJWJrE9mOklo1xmxDP/yrU2/ZoXNbLvpRgtlrA
         lMVf2o3F9m7pu55tTpjtoZkC1pVTLp1sER3G0gkFajOCnEuwpSYzl0n/Mo9bxCaGEGEs
         l67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yfwusrA/vHTen2gLyGVSqF1Zuxr8iDP38xL+HIoCxPI=;
        b=k+IZYlcvOcuQrQwExxADm3HvIunDsHZCMcwVQLz/st925+4wMbs+mnQMN4lcFsQQll
         sJAKWLskStzfqbCuf5EWLYiWcE4UmytTdYvOHfpRHXugreO+BZl46LD3GAg9dBYA+Y4/
         nFVDQJ2oqsT2ry5G89HjDthliohf4DAZy+skXtuL/BhQEa3QPEtL5WxoLMTLYnLLhhBI
         XAOvpCqEZ7Box7YUGEJk7V7TRZ1iou2VlsjAGuCVhOW6weqi5t3pJEDozsJ5b5mmoARj
         NS7M7ONWCrGBbnX/+IvD6H8avTvwYEWCkMpYXDYn71xWgPw1AYCVq0cwMCDYmyTpHmCx
         Qjcw==
X-Gm-Message-State: ACgBeo2RMplwjtWmZY0zF17DSJkeK9fa6qBeAXSppqTTXPT7pe+sBQmg
        GJk7mgcljCMVCx+QldhaUMjm2Ha6qgkV2TZRPwdwCwMPZXg=
X-Google-Smtp-Source: AA6agR6sJco1NZSWZTgvBaNZK+j/cMNesorrtn3LYX7TH6GbgoGfKURFhUi+BOvyvq/CTWtp6gM6quAwEjcBA4oKJrA=
X-Received: by 2002:a7b:c34b:0:b0:3a6:8516:a729 with SMTP id
 l11-20020a7bc34b000000b003a68516a729mr13865234wmj.83.1662464531080; Tue, 06
 Sep 2022 04:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <1662373788-19561-1-git-send-email-shengjiu.wang@nxp.com>
 <CAGoOwPQomcnO5dhkT9DBynwJo8LfVvuuwj5AYNpv0KhAGSWLEw@mail.gmail.com>
 <CAA+D8APOL1Qx0fAhyajXXzh0_tqEmDJoDBh3Xgo6uYNhV0usBw@mail.gmail.com>
 <CAGoOwPQfkT2ptdt6mBTAgPfN0NOoR4KfdLE9B2AoL+Qn6bWdFw@mail.gmail.com> <CAA+D8AMYrQsu-nM_WdrBtB4iPU2UYNDhPW-zdY_Z+-9L03gu1Q@mail.gmail.com>
In-Reply-To: <CAA+D8AMYrQsu-nM_WdrBtB4iPU2UYNDhPW-zdY_Z+-9L03gu1Q@mail.gmail.com>
From:   Nicolin Chen <nicoleotsuka@gmail.com>
Date:   Tue, 6 Sep 2022 04:41:59 -0700
Message-ID: <CAGoOwPSOEmLN+0esj2QfoadN7JZ=TJeZymxcp3MPqP4oLok70w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: Add initialization finishing check in
 runtime resume
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
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

On Tue, Sep 6, 2022 at 3:50 AM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
>> >> > +       /* Wait for status of initialization for every enabled pairs */
>> >> > +       do {
>> >> > +               udelay(5);
>> >> > +               regmap_read(asrc->regmap, REG_ASRCFG, &reg);
>> >> > +               reg = (reg >> ASRCFG_INIRQi_SHIFT(0)) & 0x7;
>> >> > +       } while ((reg != ((asrctr >> ASRCTR_ASRCEi_SHIFT(0)) & 0x7)) && --retry);
>> >> > +
>> >> > +       /* FIXME: Doesn't treat initialization timeout as error */
>> >> > +       if (!retry)
>> >> > +               dev_warn(dev, "initialization isn't finished\n");
>> >>
>> >> Any reason why not just dev_err?
>> >
>> > Just hesitate to use dev_err. if use dev_err, then should return an error.
>> > May one of the pairs is finished, it still can continue.
>>
>> Makes sense. In that case, why "FIXME" :)

> Just want to have a record/note here, need to care about this warning.

"FIXME" feels like something is wrong and literally means that it is
waiting for a fix/solution. In your case, it's not waiting for a fix
at all, but just an annotation? So, shouldn't it be just "Note:"?
