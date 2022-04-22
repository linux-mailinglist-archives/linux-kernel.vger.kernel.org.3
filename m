Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228E550C0CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 22:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiDVUtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 16:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiDVUtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 16:49:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CC9209F14;
        Fri, 22 Apr 2022 12:46:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r13so18310431ejd.5;
        Fri, 22 Apr 2022 12:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=ZCXJRqepiMM/X9hpIQkod6J8jYQslsEZGb/W6+1iH/k=;
        b=RH5YZrNy8Q1mztwF9P/pwiNXS6D591Ntr4cchSnhtXGAu64sjpjVUAMBw5lVeefIYw
         HRXQ1kk4F38u8J59nALbQbIjDbQUlQJlxbpsTUm4/ExfB7pOas09F3qFiZyWhsK5//sl
         D/kD1o0ZM7easuXgenJA6h1b+ERBHND7HPRat0YMVP9tudxi1IZrt4QlcoQdEM/dusLO
         dps+IghE4w0K7533CPxfl6vvkxzD/3OWl1o8TcyoW3AaZyeVfUGuQKdiUM2FxLsmaOjT
         jX0wkFGn/oLo62qOFod7ITzBPsy0159gqdCHObrfV0as4s4HplE5UR30AqaetWqo+tuX
         CMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=ZCXJRqepiMM/X9hpIQkod6J8jYQslsEZGb/W6+1iH/k=;
        b=gKYqiqfw3iVCQ95TovxjB5RWa+xm9pq5g5t+MSkE/+lrCxC3KJjM8jUD2yVdh+wvt0
         c7485WgsKqRyFiQs2QLlP9ZJQVTm1FZOz28TfWKSgQ7zBpahd8fH6o223yfTzc0p3MtW
         sh1uqSeeX2g36SxE27lRZiCZfp2GyrvS/ZVIYOwN6RP02wmfHHUJdz+5Avnr1Q57AxfH
         qMO/7+4xdAwjlFXXAWj/HYB0lMr1uni+V3ribQrkIFwtlq2ixpHPLxVO0aMlL7BuAT1h
         MRVwy4qYEoTwKFyhIng/wgZtgC7bUwkWO041V2g6m7EwsL4lscGyS7gvjSyeMuEg5waW
         Iv/Q==
X-Gm-Message-State: AOAM530Kanvj6oksPIRpKBAb7zZpbj+XH58gsdwXI2MFDOgUp5hznB7t
        8KTLC9OsVznW12aOpV17/5s=
X-Google-Smtp-Source: ABdhPJxUtMgv25FIn09RV/7NRmkZDcevxB8TMyX5SE3JHCN430+3rMGO2oaLb4bp0K7i4ZueYS3aUQ==
X-Received: by 2002:a17:906:7f02:b0:6cf:86d8:c31c with SMTP id d2-20020a1709067f0200b006cf86d8c31cmr5794948ejr.518.1650656506654;
        Fri, 22 Apr 2022 12:41:46 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id r17-20020a1709067fd100b006e88d3eefe6sm1037735ejs.205.2022.04.22.12.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:41:46 -0700 (PDT)
Message-ID: <c5f33892dbce61b267cc74dca50e0fae5d1270e9.camel@gmail.com>
Subject: Re: [PATCH v2 RESENT] mmc-utils: Add General command CMD56 read
 support
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        jakob.rossler@nokia.com, Avri.Altman@wdc.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Date:   Fri, 22 Apr 2022 21:41:45 +0200
In-Reply-To: <20220417111622.621650-1-huobean@gmail.com>
References: <20220417111622.621650-1-huobean@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-04-17 at 13:16 +0200, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
>=20
> We can use GEN_CMD (CMD56) to read a=C2=A0 data block with vendor-specifi=
c
> format and meaning, which is very helpful and useful for customers to
> analyze device health. This patch is to add support for this command.
>=20
> At the same time, in order to make CMD56 universal, let more users of
> mmc-utils can benefit from this. We will allow the user to enter
> [arg]
> for special commands. Because some eMMC vendors provide an additional
> set of commands beyond the GEN_CMD (CMD56) definition in the JEDEC
> specification. These additional commands are implemented using
> generic
> CMD56 commands, and they return a wealth of useful information about
> the
> state of the NAND device. For these special purposes, the [31:1]stuff
> bits in the CMD56 argument are used. You can refer to=C2=A0 Micron eMMC
> "TN-FC-32: e=C2=B7MMC Device Health Report" as an example.
>=20
> I didn't add data parsing, just print the raw data as it is vendor-
> specific.
>=20
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Acked-by: Avri Altman <Avri.Altman@wdc.com>
> Tested-by: Rossler Jakob (Nokia - DE/Ulm) <jakob.rossler@nokia.com>
> ---

Hi Ullf,

Would you be willing to merge this patch into your mmc-utils git repo?

Kind regards,
Bean
