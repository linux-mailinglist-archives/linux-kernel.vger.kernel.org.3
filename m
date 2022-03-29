Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF79B4EB515
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 23:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiC2VPb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Mar 2022 17:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiC2VP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:15:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B453B13F9D;
        Tue, 29 Mar 2022 14:13:40 -0700 (PDT)
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mz9IT-1nuX2W0O5z-00wFiU; Tue, 29 Mar 2022 23:13:39 +0200
Received: by mail-wr1-f47.google.com with SMTP id m30so26609704wrb.1;
        Tue, 29 Mar 2022 14:13:39 -0700 (PDT)
X-Gm-Message-State: AOAM5332/2qbvNQoZTYVfjGJl/d0Yim0wwS895H5ZD08+88CLTQQDGiK
        aeovVFhiyAnQB/sjtLkZYrDw7O356tuLTELbKOU=
X-Google-Smtp-Source: ABdhPJxHR5mXennkJY/lnE7PRTnpSWkihWANMe/hyzwifMKWesIU5r2Ul1WbUeI6PInYCHA7pISaCuLBifcJxx5XUpg=
X-Received: by 2002:adf:e54e:0:b0:205:a9be:c66e with SMTP id
 z14-20020adfe54e000000b00205a9bec66emr26134334wrm.192.1648588418736; Tue, 29
 Mar 2022 14:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220310195229.109477-1-nick.hawkins@hpe.com> <20220310195229.109477-9-nick.hawkins@hpe.com>
 <eb66cc83-2da9-8e19-db69-633e34fef946@canonical.com> <PH0PR84MB1718C31DB71AA2A67FEC5F6E88119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <b1cc2566-cd78-7cb4-f8a5-d6fc8065fe6e@canonical.com> <PH0PR84MB1718292B1C11F4FE83326A5388119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <fb4def96-4b20-604f-d15d-fef87eb2232d@canonical.com> <PH0PR84MB1718A2CFBFC90C9C0CAA5515881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <PH0PR84MB1718A2CFBFC90C9C0CAA5515881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 29 Mar 2022 23:13:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0fCE_NM=z68d1m9BTfuKixh1pKLw3gn+Sr7SxKb6UJAg@mail.gmail.com>
Message-ID: <CAK8P3a0fCE_NM=z68d1m9BTfuKixh1pKLw3gn+Sr7SxKb6UJAg@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device tree
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:TyuJZS76wUagmVRGh0Bp4+xWfCfqFmWe2zrbjRYZfbumVBcAGVX
 FFZJKVkJivAlLVyaBMxqfhCnqKnQpx0avcpr18CHpnpsuxmt92VNX/n0HZ4yh1JA5IdDTp4
 upkbjTfM5U8/Fh7iR0wNsMezj6d4+0wKjNG3sXftZ6qWAs7grR3fLl+NoE4xLJwfT7zio2P
 GBO1DEaZNFxrStWw+NZIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KqBs6GYC0II=:64p3bLXEDwhHFV97OcOKkw
 BQI9NPlPoyYuGqgRgZCiOlbmazZf8qqkdzjseJER7YlsHEPuAAq1KzknQ3AL6Qvl+OVPBVafb
 J52TFB60GM0C/GRWszFlN4eUHSoSjA38CY85HD2ED2aU5q+QEcqKgwNL+k94V0BYSqCAOK+YJ
 gSvz9RrfcqMOAxkfTScUPe3rtZ3Gmz07PhBYfBu+M7R+9QJq6BGpfFzafEagq1/63uC0FHkzS
 pcNQnmsD/VonUgCCTHn2h3pNr+qR037bpAJlMfkfqAfhgIEK7o6Z6YbLi4y/GPcD42SqNUQH6
 j/0UWlGN8+oK/hxtGdLkO9WeNB8VrTbvDFOZ5ENdBe2JNT9HChpkOO3GWkBoVvu3L7t6MV2Le
 hhM+cnGnTAmnV8xTyOUfz5dMcIqBDJATXthWRXvv40TcmITbc1h1kPN37gouPomIHFFyo84pW
 gu/4BTGofuNd41KRhtAAm5MNuNi2zZte92sf72FdtbqjnRHQowQvth8UWq4Drdu/JhYEn8ZmP
 OhHKxoQmbLYJsBogN8r/DwsxCA0emYa1hYIWkD+zwY/vVpXLbemWoysX6AH1LWlvEbnYWP8M/
 VvFECZ46B34e2XBqKTJjpz6JRbGX48SxUdCvkm9q1IsIqxpR+Ffi3TUNQ9CyAuoLzxdsO1tcp
 y0NwTAgM0dBQiSZ3yMo9hKTm3BjJ/b8ifzO/itWFaU+ff/HYpQ1kd1Frh/NZET4GiFB7nryea
 sOkaq2egutx++VEHcO1t4QGVOyC0DpdK/mEiGwQRugpTxkUBlg6tmfV9y90w9br+Hudl2e1o+
 SL7MKRNiJQBo1Jpk56sUZjK+vPXnWJInVFzBl0Wh6YBIzOXId4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 9:38 PM Hawkins, Nick <nick.hawkins@hpe.com> wrote:

> I am in the process of rewriting the timer driver for Linux but have hit a dilemma and I am looking for some direction. The registers that represent the watchdog timer, and timer all lay in the same register region and they are spread out to the point where there are other controls  in the same area.
>
> For instance with our watchdog controls we have:
>
> @90 the countdown value
> @96 the configuration
>
> And for our timer we have:
> @80 the countdown value
> @94 the configuration
> @88 this is actually our timestamp register but is being included in with the timer driver currently to call clocksource_mmio_init.
>
> What would be your recommendation for this? I was considering creating a gxp-clock that specifically points at the timestamp register but I still have the issue with gxp-timer and gxp-wdt being spread across the same area of registers.

I think this is most commonly done using a 'syscon' node, have a look at the
files listed by


$ git grep syscon drivers/watchdog/ drivers/clocksource/

You may also want to look at those drivers to find if any of them can
be directly reused,
this is perhaps a licensed IP block that others are using as well.

        Arnd
