Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C164CFFC2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242775AbiCGNRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241581AbiCGNRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:17:22 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBCD8BF46;
        Mon,  7 Mar 2022 05:16:25 -0800 (PST)
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mlf8e-1nrEZB2dTG-00iih2; Mon, 07 Mar 2022 14:16:23 +0100
Received: by mail-wm1-f54.google.com with SMTP id bi14-20020a05600c3d8e00b00386f2897400so5559291wmb.5;
        Mon, 07 Mar 2022 05:16:23 -0800 (PST)
X-Gm-Message-State: AOAM530Z21qC5OU6RfI9f7s+aOzJUCNxoQ+zVqSZ7JFRXBBxbhqP3wr9
        cgD37uURIsN7wXV01A8jPzgrpMtqNWvK4t7v2lo=
X-Google-Smtp-Source: ABdhPJysabRPmKcRrE/Kx/6xr0pdCTUYYBYzw9UdGhnsD750vY5MOm+A6ymUb8srsaOas8KbFQonhsx1JUb8yl80qaQ=
X-Received: by 2002:a1c:7919:0:b0:389:79c5:fe83 with SMTP id
 l25-20020a1c7919000000b0038979c5fe83mr10387102wme.173.1646658983039; Mon, 07
 Mar 2022 05:16:23 -0800 (PST)
MIME-Version: 1.0
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
 <20211224041352.29405-9-quan@os.amperecomputing.com> <51603aa7-4113-dba4-9a38-0a6683a1d249@os.amperecomputing.com>
In-Reply-To: <51603aa7-4113-dba4-9a38-0a6683a1d249@os.amperecomputing.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 Mar 2022 14:16:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1Fw5cdxtr3LeG=tNbrTRbseXP+fDzfr-2B+LqbShA99w@mail.gmail.com>
Message-ID: <CAK8P3a1Fw5cdxtr3LeG=tNbrTRbseXP+fDzfr-2B+LqbShA99w@mail.gmail.com>
Subject: Re: [PATCH v6 8/9] misc: smpro-misc: Add Ampere's Altra SMpro misc driver
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Pz4zb/GLH1qI19x07wJW5N9i+PPZOvCU5axiU12F9XtpS19weck
 b0y5o9IF0eONu5cHJidiJhMBWqr3WbNHA8PvsH3rm8nBhRQb0mwzrvuqLHIowVzMvBV1dC9
 HL2OLK1WTgbZfKKsMlQhT55g72fc8M9YnEivajODS3VI1wQ3A1FL/z40siURtQQAvqJKPld
 hDf1WyCO7IFrR2oQpKbhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nwmwTtx+NwI=:PjFNEcviuydLjHqeumDBlC
 8egcuNZTMxwVo1ZZRfu+27KDFfRydZjRnpkgsE7+kcMPu1mYSevWbTykn+cEvcdfzuqMu51RH
 csOWZpl2wZm/0OQFvzLDv+VIxZtt5/mur+OG0+atJQvX8mYTT6OuOVA5++Zj2E2B0e2cOmSSg
 aommICQ6awRLTfKyKnz+Z6k1CubhBiP+w48BNNzKSbBv00dIFgSLADvqvRM2JEOc2pnvKI/03
 m2z6wO1o1n64u6IuSYky/TCWWwfqE4fvWKSBdfN2jNPrSyMtgcPUIaXmLQn8827H5QU3o6fa/
 ZvhaTBn5VjtFOH7Ib1uF5NWmh0luaeJNdVw0x7idg5895WzYXZ2Cqc/GLu7ow1LVuYzCKTTHO
 gZXRGEIf9QkpAscFzLPt9obplKDsSv4WKzaP6lckufct9sR1lQI81opH9kg61k+qAhPD4XP0x
 X9e3w/dWj26pSKFLAcuam1UNPl8KlTYQqN25yaQQOs9vNJlHBezIKQGAq9Np+3nQQqNTbFzD/
 TbQrG/Vt/7A/j9VSm8uv5ZWI0nnocpwQkWltCxeQuZXLfFa4KhvG45rjwFq9vIFKB+8n46KZQ
 PRfKZ1SR2eFUOQCieNO0Gaa/h+WfaXXLqssM9E8/Hj3FT4YIiYLPxfreHUk87G4TuyqJr1ZT1
 nFxEeqNXKkOhNz1cNR/0sf8ljlImJnVRWpWqrZnyc67/MzTn9t8mhj92EN5f+lgEI/eXUVHH8
 jOouD+jzcEa+2gwbsLiHWT3LvHfjgkui9RiNVaRQQ2QwjEZJHVdjaOYjR0ksmaE+s4XNYtOPf
 LM7uM4WRpZXpHr7BRcIUq/Khemir+0jut0HCEhqZgEJHE89ysE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 9:32 AM Quan Nguyen <quan@os.amperecomputing.com> wrote:
> > diff --git a/drivers/mfd/smpro-mfd.c b/drivers/mfd/smpro-mfd.c
> > index a7cd64bf9eaa..5611dd30f8f4 100644
> > --- a/drivers/mfd/smpro-mfd.c
> > +++ b/drivers/mfd/smpro-mfd.c
> > @@ -28,6 +28,7 @@ static const struct regmap_config simple_word_regmap_config = {
> >   static const struct mfd_cell smpro_devs[] = {
> >       MFD_CELL_NAME("smpro-hwmon"),
> >       MFD_CELL_NAME("smpro-errmon"),
> > +     MFD_CELL_NAME("smpro-misc"),
>
> [Lee Jones]
> Misc is a Linuxisum which are not allowed in DT.
>
> What does this driver actually do?
>
> [Quan]
> This drivers is to report the boot progress to BMC and allow BMC to
> configure the Soc Power Limit of Ampere's Altra family processor.

That doesn't sound like it should be platform specific at all, but rather
a generic BMC interface. I see you already have the openbmc list on Cc,
so I assume the right people can see this. Presumably this is a BMC that
already runs on openbmc and can have a platform-independent interface
for doing this.

        Arnd
