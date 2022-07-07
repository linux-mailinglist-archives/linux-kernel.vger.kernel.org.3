Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C7456A5AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiGGOkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbiGGOkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:40:14 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB6E31DF6;
        Thu,  7 Jul 2022 07:40:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o4so26643494wrh.3;
        Thu, 07 Jul 2022 07:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version:content-transfer-encoding;
        bh=7hDgGA6xF58M+skK5QIlnWLQGV+3ttaXAD+vkX6SQTM=;
        b=OdyYpCiOrG7tlyeD9SoTpDDuQKJBKKGA87S7R8V3Q+QJ6NDK+vvD0cs3jfGUf7UMH9
         lDhOJ2LadM95+PlfXuW7J6oHRmERFWaQmQAVWaiCGpuhOSfA08EwL+dBUYiT57caITab
         j9MXKxNQiATFITxDffnWSJXK5ecwjuSz1f5ZOkxuJnlrWHxJccAzdx1y+echUhgYECSV
         pKNZ80ClGqR9sXoB2jW9ocoAInVKc7fFJToX+qLHe9BNeBUQgmeNV9MuoaT9rD6Kmskk
         tVg4vH6ToLFRFNi4TQx348MPbnO5J/Qgb7t6dGQFpcnAZkGlsDIUiwikKjXH4f7sl+9h
         /Fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=7hDgGA6xF58M+skK5QIlnWLQGV+3ttaXAD+vkX6SQTM=;
        b=rlJObrW2QODcFmYAwagxbzvIDBOdbiNG8dag6Nts0Mchr5SVwRn+av30nfIl/q+KBW
         cz0bs5lYe/613VBcFSLVqui5MyY6pB36pcnLN4XuydSNHEIFgTdspd49UraHDURBQxTg
         sFigWtwxtyYfiQMNswOP5PmvEIDC7pIbplZD6W0n2wc88s3CHrZ77rCzNdRWaNnLdgI3
         qaG8+uuxh1hrspYWyvMugS+eNpGis6EbDZHwEvj15gn696M4u3H+oB4JVkd/HL3rkSqR
         P3hso1Cv7xIGQq2B1S82vP854+ZmtU8V0GguFKKaBXq6wk1FwpYbCC3BUddzFoZ3ldU3
         upXg==
X-Gm-Message-State: AJIora92xfrSgXnpIO/4xA20xMc04u6LIMzV//TfFDz3v0oYU8BDM/6j
        FJQST+zM/QJ99phhWRq+rt3NIgn0j2w=
X-Google-Smtp-Source: AGRyM1sOSpUSUa6euRjRBfNV9zECcsAUzzpDfBRmqUBeQ0d4SlwF4Zobq3KK7HmgaZgVwAO86qi/ZA==
X-Received: by 2002:a5d:58cc:0:b0:21d:6919:7daf with SMTP id o12-20020a5d58cc000000b0021d69197dafmr22860158wrf.434.1657204808231;
        Thu, 07 Jul 2022 07:40:08 -0700 (PDT)
Received: from localhost (92.40.203.175.threembb.co.uk. [92.40.203.175])
        by smtp.gmail.com with ESMTPSA id az42-20020a05600c602a00b003a1a02c6d7bsm14485822wmb.35.2022.07.07.07.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 07:40:07 -0700 (PDT)
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
 <20220706211330.120198-11-aidanmacdonald.0x0@gmail.com>
 <H4ANER.XJSSJIHNXTEA1@crapouillou.net>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] ASoC: jz4740-i2s: Support S20_LE and S24_LE
 sample formats
Date:   Thu, 07 Jul 2022 15:25:06 +0100
In-reply-to: <H4ANER.XJSSJIHNXTEA1@crapouillou.net>
Message-ID: <jp7AjR5Hus1i7prrsjVT3n5vI5jaszTk@localhost>
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

> Le mer., juil. 6 2022 at 22:13:29 +0100, Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>> The audio controller on JZ47xx SoCs supports 20- and 24-bit
>> samples coming from memory. Allow those formats to be used
>> with the I2S driver.
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>>  sound/soc/jz4740/jz4740-i2s.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>> diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s=
.c
>> index 80b355d715ce..ee99c5e781ec 100644
>> --- a/sound/soc/jz4740/jz4740-i2s.c
>> +++ b/sound/soc/jz4740/jz4740-i2s.c
>> @@ -222,9 +222,15 @@ static int jz4740_i2s_hw_params(struct snd_pcm_subs=
tream
>> *substream,
>>  	case SNDRV_PCM_FORMAT_S8:
>>  		sample_size =3D 0;
>>  		break;
>> -	case SNDRV_PCM_FORMAT_S16:
>> +	case SNDRV_PCM_FORMAT_S16_LE:
>>  		sample_size =3D 1;
>>  		break;
>> +	case SNDRV_PCM_FORMAT_S20_LE:
>> +		sample_size =3D 3;
>> +		break;
>> +	case SNDRV_PCM_FORMAT_S24_LE:
>> +		sample_size =3D 4;
>> +		break;
>
> Did you test these? It is unclear to me, looking at the JZ4740 PM, if the
> 18-bit, 20-bit and 24-bit samples are in 4 bytes or 3 bytes.
>
> Cheers,
> -Paul
>

I was only able to test 24-bit -- in practice 20-bit seems pretty rare
and I'm finding it difficult to convert anything into that format with
standard tools like ffmpeg, sox, etc. so I can't really test it.

From what I understand, this is configuring the number of significant
bits in the FIFO and has nothing to do with the in-memory format. So
my commit message is a bit inaccurate.

DMA can only do 4-byte transfers so that's why only 4-byte formats are
usable. I suppose I could handle the 3-byte variants here, but there's
probably no point to doing that if DMA can't transfer them.

>>  	default:
>>  		return -EINVAL;
>>  	}
>> @@ -362,7 +368,9 @@ static const struct snd_soc_dai_ops jz4740_i2s_dai_o=
ps =3D
>> {
>>  };
>>  #define JZ4740_I2S_FMTS (SNDRV_PCM_FMTBIT_S8 | \
>> -		SNDRV_PCM_FMTBIT_S16_LE)
>> +			 SNDRV_PCM_FMTBIT_S16_LE | \
>> +			 SNDRV_PCM_FMTBIT_S20_LE | \
>> +			 SNDRV_PCM_FMTBIT_S24_LE)
>>  static struct snd_soc_dai_driver jz4740_i2s_dai =3D {
>>  	.probe =3D jz4740_i2s_dai_probe,
>> --
>> 2.35.1
>>=20

