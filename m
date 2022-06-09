Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8208D544346
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiFIFrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbiFIFr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:47:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FA223B557;
        Wed,  8 Jun 2022 22:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654753626;
        bh=CK1mrzVGgNsxBX50Lg3eVfTjvuYYZTQEUKDaJ6KAwtA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=AG8PQw5BbksWUtL/e77b539/4DsN39MLJdJ4x0pF8FsSpLDhyLwJlVxzWm/1pkvqX
         HypYBaje6j831XPHQi/GFofAfavMFed9yiGN2aeb2OGE6DYYgNTKIPHnf9+J+ZOEEr
         CII/yb2XGnq8g7yU8PMHcGM2K0QNASGxH7cgihD8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.0.188] ([62.143.94.109]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bfw-1nh0bM1ad4-0181NO; Thu, 09
 Jun 2022 07:47:06 +0200
Message-ID: <dbd56518-e688-3b3b-08ae-63f66004e62a@gmx.de>
Date:   Thu, 9 Jun 2022 07:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/5] dt-bindings: input: Increase maximum keycode value
 to 0x2ff
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Artur Rojek <contact@artur-rojek.eu>,
        Maxime Ripard <mripard@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220608211207.2058487-1-robh@kernel.org>
 <20220608211207.2058487-2-robh@kernel.org>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20220608211207.2058487-2-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r5i5vKTtld9WbI0jJeooo/iDNKFkEgcMttR/u2647QaNJg3sMnb
 Vzkx+hKMkjoF11eI530jtAI2p1JKgmm4B4GRNgX/pjwvqIuxlOBpLr6NVTEYPZFWd6sS359
 fTuImSMqSPBGbcZH08yH5mfz2890zzw08HSQLbH0b0nWQH9e2HsDUiQRs0RySU9x8XllBT1
 JPViqwjJrPWua0LaRxaYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PSEr1mVjB8o=:cELoQFPPluIiE0AFnXuXky
 T8fmMgvq7C21Q8lPfzowLXyDFVGgU48k2qareqgpNtz45oLlez0m9oTng7DVQ9SxZ54vv92bD
 ZPjHNh2dkp30dTbUo1AskzC5mz9N2kg/yjmBMVQqaFUVOJWVZNarGRyZOIkIxVEPowOUWuKU6
 XXxgewhBw+aFWjOFFCcd0mGZm2ClP2OjdPB2H7GSdTGwJFl6TDL8bsP4fVF0Nzt4dEz6HkyOU
 ol6Vmx8GMMSFSzl4goUSqnnq3TgNCJpvBmu8S5w7cm/PApkUEAILkBlaAfqbo7JRZRH84f1qo
 85p/O6DapVRLFueQLMSMS/z+qvxfqGcnbt1f/34b/SzUJ3yLWVFit345OPCxxf+qLR2v8YI2I
 4WMLYhMedBbBTCaJqsA8kutUUroaThXnbxLQ00gup5QV+fKtYzVeDcSJneVPuwb5kJUC1nCjg
 jSpKwOqjm/6FMsczij/GzFAHDsAFm0VG9OBfveTDjsRf0WIAjapcKVMHjk6cbsUnUP2EHDtCT
 P8Ge8Bw8YGyEyBz2qGpcORBnCmqfEn1miyyNZBVUD4Ns3L9RqTimElkSczMB44AptmqLh0F19
 KbVNF5ghXUlIB8YV4CthJbz8UeZrgyh4+sVeMtGZyzf37ijZf/9R2aqnoL9TUvoI24ANnpaAV
 K5GxykvZkuNz9lNLa1TxG9s+i+UuhUHM5SiBXDZ6WjtqO0dpGWKYZIBTRkJ5IQVesUNAouySj
 Q/ILB2/2LcUivUaXt6J/Geof2hwmumNqZnNl7AAHOdCU5uWyS5m9I3LvInKMCvaRdyLnGxy4f
 2LUsUkHr1M97junNZgf49vAuZMVi03PVN2P6wO7se3rbkaxMvnYWHe9hmUa4ysST/K0AlFi+5
 y9y4rfwuEqrBYo/0TwgxYRUgjvM/79rRl/YWD2llSbIDvMG3e5rwcxRMRzK73oNtj1wc5lv7G
 eC0PzWlfkh7sNFU6zIwnvvwnbsoD5v4La0ZTH05PN26yveQTEcYNLmIX6LldKDmXyNnxnTdDg
 ehEqpGBkcpvXjGcY4rVqmFiveeIhWnsm8auOYbRVOz997zqY52UJotWQg/oO19/Bf4OvARN7x
 HGVSfdGCeqqi2oQeNW2OQEM8nYDIHFCcPZtqI41WWWrfEm4wWgNN1AoMQ==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 23:12, Rob Herring wrote:
> The maximum keycode value for Linux is 0x2ff, not 0xff. There's already
> users and examples with values greater than 0xff, but the schema is not
> yet applied in those cases.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/input/input.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Docume=
ntation/devicetree/bindings/input/input.yaml
> index d41d8743aad4..43d2f299c332 100644
> --- a/Documentation/devicetree/bindings/input/input.yaml
> +++ b/Documentation/devicetree/bindings/input/input.yaml
> @@ -21,7 +21,7 @@ properties:
>       $ref: /schemas/types.yaml#/definitions/uint32-array
>       items:
>         minimum: 0
> -      maximum: 0xff
> +      maximum: 0x2ff

Can this value of 0x2ff be make exportable such that we can use it as a
reference in devicetree/bindings/input/adc-keys.yaml. E.g. define a type
that only take values in the 0-0x2ff range?

Best regards

Heinrich

>
>     poll-interval:
>       description: Poll interval time in milliseconds.

