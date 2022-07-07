Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F8356A54E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiGGOXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiGGOXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:23:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AA627B0C;
        Thu,  7 Jul 2022 07:23:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bk26so11487733wrb.11;
        Thu, 07 Jul 2022 07:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version:content-transfer-encoding;
        bh=NUHMqETelgKBMcAu+0SqzcDlAwUOK8yrepUxvvqttSY=;
        b=ebmq4wsrTY7n81CmTuWPBXuy4+uRkMUymgPTu0tKIVyN3L5u8nQrKnWTVjCaLhDc0w
         q7F6sxxzi2FkCeK1lP1JWVi5yr59dT5rzsbmiraV7gwO9+wnvKoRo3Ka9gynQfMjM2S3
         41mn87tBr98ibvSQfvdtmdIpkx4a4avfL5VsWRTJc1cmdEIegImJ9ypk3Dl2lR/fIMzL
         DRyWfUOyasTKkbhrEdHHsrjoNC6crbz/7XeKhlXevNx7unwyCBxegVMv/LdxBwGwKqjS
         aHZ/6K3NoiNbaCVSA5Qt4EPsekOnrYvbmnVkr3p6fES4TxvdTVHrinPHSPaLte2C2LQB
         x0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NUHMqETelgKBMcAu+0SqzcDlAwUOK8yrepUxvvqttSY=;
        b=FBqd863WWIgr7F634qkoJnm+7V9aBe7AStoElYOzOtAIP5zIY3mn/iDGysWGSvD1ZD
         +E/anRGalGNI+D3Nlw9FfXtJNpvGsT+Wm51zw4Z5ZjAYZEHrqSWJT6Tvx4ZUdqUMibI7
         QNXxEdgRcV0PgIrfD0pQ89xr5W5tDZJ21PqoNoR9Oohqgu7LN0KPPoC+/zIuqQ0EixC7
         Xy111ehsR4iuXap8EDJfVc81v1tM2MhWLlhNO0H8xnl44MBfpCpHNt+a0Q3myWg4ATc0
         W4YNCmyGGlV1AfKylTO9J6E+fFG7Z7A4A3AxpFCn89LsOHK8KjsPzzHDblUuuQ6dcNFm
         gC3g==
X-Gm-Message-State: AJIora+rEM/DbTp8JefnNapXki3ShPSjxPDanIMzV42aI4MlE0kVIkf6
        BRmw03ZZjGyXuuPFNrBlpHQ=
X-Google-Smtp-Source: AGRyM1vc0Rv/d4m30UdfyxezbdL00+nDaA1k0pzbL7Tp7PXXN6jWmgpXSBJiOt5Y38DOzQCsYh8kug==
X-Received: by 2002:a5d:6da3:0:b0:21b:aaf5:b814 with SMTP id u3-20020a5d6da3000000b0021baaf5b814mr42352435wrs.140.1657203824787;
        Thu, 07 Jul 2022 07:23:44 -0700 (PDT)
Received: from localhost (92.40.203.179.threembb.co.uk. [92.40.203.179])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c204f00b0039c5cecf206sm28717513wmg.4.2022.07.07.07.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 07:23:44 -0700 (PDT)
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
 <20220706211330.120198-10-aidanmacdonald.0x0@gmail.com>
 <HU9NER.25VYXWS2PRRL2@crapouillou.net>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] ASoC: jz4740-i2s: Make the PLL clock name
 SoC-specific
In-reply-to: <HU9NER.25VYXWS2PRRL2@crapouillou.net>
Date:   Thu, 07 Jul 2022 15:24:52 +0100
Message-ID: <rQqB9wAMTrydT1hKl1pUshBKW82RHbiR@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Cercueil <paul@crapouillou.net> writes:

> Le mer., juil. 6 2022 at 22:13:28 +0100, Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>> On some Ingenic SoCs, such as the X1000, there is a programmable
>> divider used to generate the I2S system clock from a PLL, rather
>> than a fixed PLL/2 clock. It doesn't make much sense to call the
>> clock "pll half" on those SoCs, so the clock name should really be
>> a SoC-dependent value.
>
> Do you really need the .set_sysclk() callback? I've never seen it used on=
 any
> of the Ingenic boards I have, so to me it's pretty much dead code. Unless=
 you
> do use this callback, I'd suggest to drop this patch until you do need it.
>
> Cheers,
> -Paul
>

Yes, one of my boards has an external codec (AK4376) that needs the
sysclock and I've patched simple-card to be able to set a non-zero
sysclock ID.

>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>>  sound/soc/jz4740/jz4740-i2s.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>> diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s=
.c
>> index 3a21ee9d34d1..80b355d715ce 100644
>> --- a/sound/soc/jz4740/jz4740-i2s.c
>> +++ b/sound/soc/jz4740/jz4740-i2s.c
>> @@ -71,6 +71,8 @@ struct i2s_soc_info {
>>  	struct reg_field field_tx_fifo_thresh;
>>  	struct reg_field field_i2sdiv_capture;
>>  	struct reg_field field_i2sdiv_playback;
>> +
>> +	const char *pll_clk_name;
>>  };
>>  struct jz4740_i2s {
>> @@ -265,7 +267,7 @@ static int jz4740_i2s_set_sysclk(struct snd_soc_dai =
*dai,
>> int clk_id,
>>  		clk_set_parent(i2s->clk_i2s, parent);
>>  		break;
>>  	case JZ4740_I2S_CLKSRC_PLL:
>> -		parent =3D clk_get(NULL, "pll half");
>> +		parent =3D clk_get(NULL, i2s->soc_info->pll_clk_name);
>>  		if (IS_ERR(parent))
>>  			return PTR_ERR(parent);
>>  		clk_set_parent(i2s->clk_i2s, parent);
>> @@ -387,6 +389,7 @@ static const struct i2s_soc_info jz4740_i2s_soc_info=
 =3D {
>>  	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 8, 11),
>>  	.field_i2sdiv_capture	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>>  	.field_i2sdiv_playback	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>> +	.pll_clk_name		=3D "pll half",
>>  };
>>  static const struct i2s_soc_info jz4760_i2s_soc_info =3D {
>> @@ -395,6 +398,7 @@ static const struct i2s_soc_info jz4760_i2s_soc_info=
 =3D {
>>  	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
>>  	.field_i2sdiv_capture	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>>  	.field_i2sdiv_playback	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>> +	.pll_clk_name		=3D "pll half",
>>  };
>>  static struct snd_soc_dai_driver jz4770_i2s_dai =3D {
>> @@ -421,6 +425,7 @@ static const struct i2s_soc_info jz4770_i2s_soc_info=
 =3D {
>>  	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
>>  	.field_i2sdiv_capture	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
>>  	.field_i2sdiv_playback	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>> +	.pll_clk_name		=3D "pll half",
>>  };
>>  static const struct i2s_soc_info jz4780_i2s_soc_info =3D {
>> @@ -429,6 +434,7 @@ static const struct i2s_soc_info jz4780_i2s_soc_info=
 =3D {
>>  	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
>>  	.field_i2sdiv_capture	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
>>  	.field_i2sdiv_playback	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>> +	.pll_clk_name		=3D "pll half",
>>  };
>>  static const struct snd_soc_component_driver jz4740_i2s_component =3D {
>> --
>> 2.35.1
>>=20

