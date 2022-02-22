Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927FB4BF72A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiBVLXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiBVLXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:23:43 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B6A130185;
        Tue, 22 Feb 2022 03:23:18 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id bu6so4253917qvb.10;
        Tue, 22 Feb 2022 03:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5HsbQV9ScwzASe1X9e3s4pz3SR1RiwJqEbzvWPMyR0E=;
        b=KLJyH52hOPOXoRD9so2gARkzEoVGENAUgdx1dQFi7LLdS1ohq+Bcv4myHL2uoeWo60
         Wbj0iGa7LEcmfve8Bel5J5oB4HYvO/wlh4HOATaimmbsYeyP5snISEltT+Wl8qEQcp9Z
         xOnUxzabGTKjDhjkqPbB8ysnJgvGmzsrUDL+h4ujF3jv18TR/dCUVm+V7035XwB2TSFE
         Uq9JWTERxTGalBFJBNhmUCvNrilv8DK0u3GrGqOqByzkJubf23aWdTEboRFt95PWnGZo
         rYmiLxz+keIQZm6aSmijg3xYmguLLLP+t6+X6zf4DSjey59u5teSC8gBw5O2piSut7sm
         d0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=5HsbQV9ScwzASe1X9e3s4pz3SR1RiwJqEbzvWPMyR0E=;
        b=cLmMMeXaiuOtKjhg02HaqL4oAEpkopjfsDZGncmSO9yyZxfyP7In64RwIf61niIIhL
         Pal/Nf1cDd/0ZrEvLfAFFLoiDCi+gIA49rGLHdAd6b3NqQ3dYjFvXTtqk8QDa67WdxvD
         rsQHtqcIJ/ETdp1ws6PcNFEdqH/f6FOwRTrOoZ1KWP46FrbDy7GNZybvJOpWz+t8O9ag
         8ondVBoYjXsCvBXxExHc019LqBWHJNhxt09g3mu/IDDdsX8X3Afkp7HdLGl01wgl+5NH
         JSkxRK8rY0KJXChVlwKW9RMhEV1pfIxc3RY7IfVoR1LZTgBgBnA19kIVVxFjiT7gFSLb
         c84A==
X-Gm-Message-State: AOAM531CzenC0RIRPNMDMQKiFTwTbVYtEYbhWgowxtN7wEVF74GDZEta
        1pHSB14itj+rvg4jCw35mww=
X-Google-Smtp-Source: ABdhPJznmAoAgsnj0xI2MwUfbbSCmGXzBImvAZw/zCxLKRO78cHlxJfooxIBFbSI+1F0RnKhDmFWrA==
X-Received: by 2002:ac8:5a53:0:b0:2d2:b6cd:6d59 with SMTP id o19-20020ac85a53000000b002d2b6cd6d59mr21659197qta.203.1645528997472;
        Tue, 22 Feb 2022 03:23:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c21sm30924298qtx.89.2022.02.22.03.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:23:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 22 Feb 2022 03:23:15 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Adamski <krzysztof.adamski@nokia.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        Agathe Porte <agathe.porte@nokia.com>,
        Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: add tmp464.yaml
Message-ID: <20220222112315.GA1702745@roeck-us.net>
References: <20220218150908.1947772-1-linux@roeck-us.net>
 <YhNWVLHYVtCvdGhi@localhost.localdomain>
 <66e6b131-274f-454b-44f6-17df879d71a9@roeck-us.net>
 <YhQDGHD3S0qwP2OB@localhost.localdomain>
 <238e6fb0-cd77-4772-3e92-23941dc74403@roeck-us.net>
 <YhSPd79vHLO+73ln@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YhSPd79vHLO+73ln@localhost.localdomain>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:23:35AM +0100, Krzysztof Adamski wrote:
> Dnia Mon, Feb 21, 2022 at 02:11:17PM -0800, Guenter Roeck napisał(a):
> > On 2/21/22 13:24, Krzysztof Adamski wrote:
> > > Dnia Mon, Feb 21, 2022 at 08:16:15AM -0800, Guenter Roeck napisał(a):
> > > > > I still thing we should have the same format here and in tmp421, for
> > > > > consistency. If use the same property name, "ti,n-factor" but on tmp421
> > > > > you have use 32bit value while here you have to use 8bit (which is weird
> > > > > in DT, BTW), it might be confusing.
> > > > > Back when we did this for TMP421, there was some discussion and we
> > > > > settled on this approach, why do it differently now?
> > > > > 
> > > > 
> > > > I seem to recall from that discussion that there was supposedly no way to
> > > > express negative numbers in devicetree. Obviously that is incorrect.
> > > 
> > > Well, I would still argue it *is* correct. DT only support unsigned
> > > numbers and, really, only 32 or 64 bit. See the chapter 2.2.4 Properties
> > > in:
> > > https://github.com/devicetree-org/devicetree-specification/releases/download/v0.4-rc1/devicetree-specification-v0.4-rc1.pdf
> > > 
> > > Devicetree also supports array of bytes, and this is how we get the
> > > /bits/ magic but this is just a syntactic suggar. The same is true about
> > > negative values. Just decompile your compiled DTB and you will see.
> > > To put it in other words - DTS does support negative values, DTB don't.j
> > > 
> > > > In addition to that, I strongly suspect that the tmp421 code as written
> > > > does not work. Its value range is specified as 0..255, but it is read with
> > > >     err = of_property_read_s32(child, "ti,n-factor", &val);
> > > > and range checked with
> > > >     if (val > 127 || val < -128) {
> > > >                dev_err(dev, "n-factor for channel %d invalid (%d)\n",
> > > >                       i, val);
> > > >                return -EINVAL;
> > > >        }
> > > > 
> > > > That just looks wrong. Either the value range is 0..255 and checked
> > > > as 0 .. 255, or it is -128 .. 127 and must be both checked and specified
> > > > accordingly. This made me look into the code and I found how negative
> > > > numbers are supposed to be handled.
> > > 
> > > It worked for me when I tested that. I could redo the test, if you are
> > > unsure. The code also looks good to me. I wasn't convinced for this
> > > format in yaml but after the whole discussion we had, we settled on
> > > that, with Robs blessing :)
> > > 
> > 
> > It is hard for me to believe that you can enter, say, 255 into the dts file
> > and of_property_read_s32() reads it as -1. If so, of_property_read_s32()
> > could never support values of 128 and above, which seems unlikely.
> > 
> > Now, I can imagine that one can enter 0xffffffff and of_property_read_s32()
> > returns -1, but that isn't what is documented for tmp421.
> > 
> 
> Yes, you are correct, you have to enter either <(-1)> or <0xffffffff>
> (which is the same thing). I was quite confused on how to specify that
> in DT bindings and apparently maybe we did not understand each other
> well enough back when the patch was submitted. The code and the
> description is correct, though, so the question is how to properly set

Here is where we disagree. The bindings say:

    items:
      minimum: 0
      maximum: 255

Based on this, the following devicetree configuration should be correct.

        tmp423a@4c {
                compatible = "ti,tmp423";
                reg = <0x4c>;
		#address-cells = <1>;
                #size-cells = <0>;
 
                channel@1 {
                    reg = <1>;
                    ti,n-factor = <255>;
                };
        };

However, it results in:

tmp421 4-004c: n-factor for channel 1 invalid (255)
tmp421: probe of 4-004c failed with error -22

Either the range is 0 ... 255 and we need to accept 0 ... 255,
or the range is -128 ... 127 and we need to accept -128 ... 127.

> "minimum" and "maximum" value.
> 
> I think I should at least update the example of tmp421 in the binding to
> use <(-1)> notation to make it obvious that it works this way. But I
> guess we need Rob to help us understand how this should be specified.
> 
> In any case, if you drop usage of /bits 8/ and keep the property naitive
> 32 bit, both tmp421 and tmp464 bindings will be compatible with each
> other.
> 
> @Rob, if I want a property ti,n-factor be in in range from <(-128)> to
> <127>, so that we can use of_property_read_s32() and then use just one
> byte of that, how to specify that in yaml file? For TMP421, we currently
> have:
> 
>  ti,n-factor:
>    description: |
>      The value (two's complement) to be programmed in the channel specific N correction register.
>      For remote channels only.
>    $ref: /schemas/types.yaml#/definitions/uint32
>    items:
>      minimum: 0
>      maximum: 255
> 
> which is confusing.
> 
> Guenter is proposing to use
>  $ref: /schemas/types.yaml#/definitions/int8
>  items:
>    minimum: -128
>    maximum: 127
> 
> and of_property_read_u8() for the same property on another driver, so
> usage of /bits/ 8 is required. Which approach is better in your opinion?
> 

I could declare the property as int32, use of_property_read_s32, and
validate the range in the driver. However, the range still needs
to match the documentation.

Guenter
