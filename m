Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37D95B1820
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiIHJLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiIHJLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:11:09 -0400
X-Greylist: delayed 341 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Sep 2022 02:10:55 PDT
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B0A11CD67;
        Thu,  8 Sep 2022 02:10:51 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 28B182B05F4F;
        Thu,  8 Sep 2022 05:05:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 08 Sep 2022 05:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1662627907; x=
        1662631507; bh=+4JBKyAgNVyjuO006dBopVHz/GfCNknoVdO7ePY3/Hk=; b=C
        mcN0b/Od190n5MB0AdCLVFloes8ieySxEWAWqoGU4VGEhq+HpQXAdss5LDBNdtak
        Iac9/dkzpcDMALjjhFgcy7ubvhpd32g/Hk1jHdd346BD9cpqEbt+4zAQAXxL48eV
        AZiGdAckOmTQxCbLIjl4KZA/fLfbx/USfMPPDRiaTo3nIGbMsK4iyHebSH7QSw/p
        qCUrYrwkw+esyl4OvrU4GGya31novdNFCHY0qbngYdeY+6BVvvMjHSjRa/ywyUKX
        oG9hIrS50AaGE67DDHQbHhyWk7EQtUP/wZW1mtI7dCkegj0Kaqn1LANOPibqWmzR
        x37tO/2DerEmm3Aax1K9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662627907; x=
        1662631507; bh=+4JBKyAgNVyjuO006dBopVHz/GfCNknoVdO7ePY3/Hk=; b=j
        m3vqUBDfEvIx2QMQAkNXrw6a+bx7x3E7c6/fKzMcib9tkSOgwo/myH6xOcN+vRaC
        U70gsxP7gwLeZy3+ExVtgxi+IeEFXJNHqgv7x7eSIT4l4NiNTq2F99k+R/MvTH5f
        idht99RCqxXdYQ58xFLJeiGCPnf9L2cd+ONMzbhHMvywpuSKZ0CQdaQmxjvilgau
        yKGzabIFzOZiUMOacyxc+83ys09wNBlZkTKoeICvqsj+IErAl1VxM+4BDe9E5e/W
        PFuErol62Qbw9UYprmAjqvKgOQELCDrpiLMU8WddpkXMIoY/B6XftdEfUMzRf6if
        uLyHC/pHlAiyxh072SqoQ==
X-ME-Sender: <xms:QrAZY_dbG31HtUcpaNeQxBDzBR_nFQScOqMh5mJDCYQFFMU13sBSXg>
    <xme:QrAZY1Mu8Bqhlev1Fc1n2s7c_En5tWvLv4PeyOlRBsBjTM_cnTWZH55u1EjiHB_zD
    aKGh_yrkKyjY8o6hY0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:QrAZY4ijxueD9zKsbowy653ahcuHJrSNOypzTMi1yP67FiiMGAgo9w>
    <xmx:QrAZYw89wxygUMlhNz8tcjXS4BiBGfr07yglIEKEHp-6UnD9fCvYBA>
    <xmx:QrAZY7s9FDDlNkrEqB0lLip6DdRRDmDSW_J6FuYWUuXXlVLrHB7rag>
    <xmx:Q7AZY0G7qXDQM-beMAjWGZHqemwXc-2oPtVmS3gfrTC3F0EvZFYatNaHp3w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0D5A8B60083; Thu,  8 Sep 2022 05:05:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <d03941e4-5ea6-4ff3-887a-423f5caedf4c@www.fastmail.com>
In-Reply-To: <CAMuHMdWVcoHqPa5AqoPqvw=ZuHdqG7p5HWOHUx9ecNZvzUG4Xw@mail.gmail.com>
References: <mhng-d98d3324-5f4b-4cb0-a116-522b124dcdea@palmer-ri-x1c9>
 <7423117.EvYhyI6sBW@kista>
 <84f28dc3-3b65-ea70-4fa4-765d0c773c28@microchip.com>
 <CAMuHMdWVcoHqPa5AqoPqvw=ZuHdqG7p5HWOHUx9ecNZvzUG4Xw@mail.gmail.com>
Date:   Thu, 08 Sep 2022 11:04:45 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Conor.Dooley" <Conor.Dooley@microchip.com>
Cc:     "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Chen-Yu Tsai" <wens@csie.org>, linux-sunxi@lists.linux.dev,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Olof Johansson" <olof@lixom.net>
Subject: Re: [PATCH 00/12] riscv: Allwinner D1 platform support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022, at 9:00 AM, Geert Uytterhoeven wrote:
> On Wed, Sep 7, 2022 at 10:43 PM <Conor.Dooley@microchip.com> wrote:
>> On 06/09/2022 21:29, Jernej =C5=A0krabec wrote:
>> > Dne =C4=8Detrtek, 01. september 2022 ob 20:10:13 CEST je Palmer Dab=
belt napisal(a):
>> >> On Sun, 14 Aug 2022 22:08:03 PDT (-0700), samuel@sholland.org wrot=
e:
>> >>>  arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dts cr=
eate
>> >>>  mode 100644
>> >>>  arch/riscv/boot/dts/allwinner/sun20i-d1-common-regulators.dtsi c=
reate
>> >>>  mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.1=
4.dts
>> >>>  create mode 100644
>> >>>  arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dts c=
reate
>> >>>  mode 100644
>> >>>  arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.=
dts
>> >>>  create mode 100644
>> >>>  arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.=
dts
>> >>>  create mode 100644
>> >>>  arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel.dtsi =
create
>> >>>  mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-do=
ck.dts
>> >>>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-liche=
e-rv.dts
>> >>>  create mode 100644
>> >>>  arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts creat=
e mode
>> >>>  100644 arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts create =
mode
>> >>>  100644 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
>> >>
>> >> I'm assuming these are aimed at the RISC-V tree?  I'm generally OK=
 with
>> >> that, though the DT folks have pointed out a handful of issues tha=
t look
>> >> pretty reasonable to me.
>> >
>> > DT changes for Allwinner ARM SoCs go trough sunxi tree. Should this=
 be handled
>> > differently for RISC-V?
>>
>> Microchip RISC-V DT go via a Microchip tree to Palmer. The other stuf=
f gets
>> picked directly by him as it has no clear "owner". I think it would b=
e nice
>> to be consistent for the new {renesas,sunxi} stuff and send those via=
 vendor
>> trees to Palmer too. Just my 2 cents...
>
> Wasn't the intention behind the rename s/arm-soc/soc/ to start
> accepting PRs for non-arm DT, too?
> Especially if we start having dependencies due to riscv DTS files
> including arm64 DTS snippets through scripts/dtc/include-prefixes/arm6=
4/.

Yes, absolutely. My impression was that most architecture
maintainers prefer to handle the SoC support themselves, and
I would not want to step on anyone's toes with this, but I'm
definitely happy to take pull requests for dts files etc on
any architecture if that helps.

    Arnd
