Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BED1576669
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiGORy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiGORyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:54:54 -0400
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC5B54CB5;
        Fri, 15 Jul 2022 10:54:52 -0700 (PDT)
Received: from 1oCPWT-000BsI-W3 by out3a.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1oCPWb-000C2b-Uv; Fri, 15 Jul 2022 10:54:49 -0700
Received: by emcmailer; Fri, 15 Jul 2022 10:54:49 -0700
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3a.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1oCPWT-000BsI-W3; Fri, 15 Jul 2022 10:54:41 -0700
Received: from tsdebian (97-120-89-198.ptld.qwest.net [97.120.89.198])
        by mail.embeddedts.com (Postfix) with ESMTPSA id E09C21C0A;
        Fri, 15 Jul 2022 10:54:40 -0700 (MST)
Message-ID: <1657907657.2829.1.camel@embeddedTS.com>
Subject: Re: [RFC PATCH v2] ARM: dts: Add TS-7553-V2 support
From:   Kris Bahnsen <kris@embeddedTS.com>
Reply-To: kris@embeddedTS.com
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mark Featherston <mark@embeddedTS.com>
Date:   Fri, 15 Jul 2022 10:54:17 -0700
In-Reply-To: <eb993f8d-e72f-aba3-e7a4-1bbd2ac00f6c@linaro.org>
References: <20220713221233.8486-1-kris@embeddedTS.com>
         <55dccabb-41e9-dc45-f404-c333f5472e75@linaro.org>
         <1657833995.2979.1.camel@embeddedTS.com>
         <eb993f8d-e72f-aba3-e7a4-1bbd2ac00f6c@linaro.org>
Organization: embeddedTS
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-IP: 66.210.251.27
X-Env-From: kris@embeddedTS.com
X-Proto: esmtps
X-Revdns: wsip-66-210-251-27.ph.ph.cox.net
X-HELO: mail.embeddedts.com
X-TLS:  TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256
X-Authenticated_ID: 
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Mime-Version:References:In-Reply-To:Date:To:From:Message-ID; bh=dxvJjUrX64Cs5hkRtbhBYZ+CBeeqYYUwDDG4GscCgRg=;b=RCNRIPqG09r6kH74N7as77/3G7UZC/jdj5YvhraTRW4wujMa1l3NoCN2JRBjhbjL5PYW+69kXwBTzLYLRUeBob/vE+nszuiHZWnjSpRt0RHh/stQGD/6yo5O1NsCs3apgzZd5IvSOAnhuOgEnCNENPR9hudArlDpMtzkzTNBE8hW0ItYHd8Jsyk9mzToxeftTRmpxiXX0keBzL++UcnZKYmlSKnQipOlWRK9DoMo6gTHsKNqosF/3MOGWpRaWZXcx9l9/oMukJt2QdES/5ROglhoD6nj0FBnQNZf8RjjnTHM/82vGjSklGem2ypr40yBDtmbCTRv1ulIjGi4vdq5OQ==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-15 at 08:42 +0200, Krzysztof Kozlowski wrote:
> On 14/07/2022 23:26, Kris Bahnsen wrote:
> > On Thu, 2022-07-14 at 10:34 +0200, Krzysztof Kozlowski wrote:
> > > On 14/07/2022 00:12, Kris Bahnsen wrote:
> > > > Add initial support of the i.MX6UL based TS-7553-V2 platform.
> > > 
> > > Use subject prefix matching the subsystem. git log --oneline --
> > 
> > Can you please elaborate? The subject prefix is "ARM: dts:", I'm not
> > sure what is missing. Should it be something like
> > "ARM: dts: imx6ul-ts7553v2:" in this case?
> 
> Run the command, you will see.

I had previously run the command and the output of it did not make sense in
the context of your prior comment. Forgive my ignorance, but I'd like to
understand specifically what you mean here so we can do the correct thing
in the future.

$ git log --oneline -- | head -n 20
d14ee2d5a506 ARM: dts: Add TS-7553-V2 support
b047602d579b Merge tag 'trace-v5.19-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
1e1fb420fe68 samples: Use KSYM_NAME_LEN for kprobes
e3655dfa5805 fprobe/samples: Make sample_probe static
0bb7e14c8e15 blk-iocost: tracing: atomic64_read(&ioc->vtime_rate) is assigned an extra semicolon
0a6d7d45414a ftrace: Be more specific about arch impact when function tracer is enabled
495fcec8648c tracing: Fix sleeping while atomic in kdb ftdump
7edc3945bdce tracing/histograms: Fix memory leak problem
72a8e05d4f66 Merge tag 'ovl-fixes-5.19-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs
29851567d1aa Merge tag 'drm-fixes-2022-07-12' of git://anongit.freedesktop.org/drm/drm
0d8ba24e72b6 Merge tag 'x86_bugs_retbleed' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
c27c753ea6fd x86/static_call: Serialize __static_call_fixup() properly
ce114c866860 Merge tag 'x86_bugs_retbleed' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
3590b44b9434 Merge tag 'drm-misc-fixes-2022-07-07-1' of ssh://git.freedesktop.org/git/drm/drm-misc into drm-fixes
42e0a87233e3 Merge tag 'drm-intel-fixes-2022-07-07' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
7de96365878f Merge tag 'amd-drm-fixes-5.19-2022-07-06' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
5a29232d870d Merge tag 'for-5.19-rc6-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
23458ac91dc8 Merge tags 'free-mq_sysctls-for-v5.19' and 'ptrace_unfreeze_fix-for-v5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
8e59a6a7a4fa Merge tag 'mm-hotfixes-stable-2022-07-11' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
b5374396e5de Merge tag 'modules-5.19-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux

> 
> > 
> > > 
> > > > 
> > > > Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> > > > ---
> > > > 
> > > > V1->V2: Implement changes recommended by Rob Herring and dtbs_check
> > > > 
> > > > RFC only, not yet ready to merge, more testing needed and we're working on
> > > > SPI LCD support for this platform.
> > > > 
> > > > Specifically, I have a few questions on some paradigms and dtbs_check output:
> > > > 
> > > > imx6ul-ts7553v2.dtb: /: i2c-gpio: {'compatible': ... \
> > > > 'magnetometer@c': {'compatible': ['asahi-kasei,ak8975'], 'reg': [[12]]}}}} \
> > > > is not of type 'array'
> > > >   I'm not sure what this error is referring to as I've copied the example in
> > > >   invensense,mpu6050.yaml almost verbatim. Is this an issue with our patch
> > > >   or a false positive from dtbs_check?
> > > 
> > > You would need to paste entire error, maybe with checker flags -v.
> > 
> > Here is the verbose output. I'm not familiar enough yet with the schema and its
> > validation code to catch what is wrong and would appreciate any insight.
> > 
> > Check:  arch/arm/boot/dts/imx6ul-ts7553v2.dtb
> > /work/arch/arm/boot/dts/imx6ul-ts7553v2.dtb: /: i2c-gpio: {'compatible': ['i2c-gpio'], \
> > '#address-cells': [[1]], '#size-cells': [[0]], 'pinctrl-names': ['default'], \
> > 'pinctrl-0': [[58]], 'sda-gpios': [[11, 5, 6]], 'scl-gpios': [[11, 4, 6]], \
> > 'imu@68': {'compatible': ['invensense,mpu9250'], 'reg': [[104]], \
> > 'interrupt-parent': [[55]], 'interrupts': [[1, 1]], 'i2c-gate': {'#address-cells': [[1]], \
> > '#size-cells': [[0]], 'magnetometer@c': {'compatible': ['asahi-kasei,ak8975'], \
> > 'reg': [[12]]}}}} is not of type 'array'
> > 
> > Failed validating 'type' in schema['patternProperties']['(?<!,nr)-gpios?$']:
> >     {'items': {'additionalItems': {'$ref': '#/definitions/cell'},
> >                'items': [{'oneOf': [{'maximum': 4294967295,
> >                                      'minimum': 1,
> >                                      'phandle': True,
> >                                      'type': 'integer'},
> >                                     {'const': 0, 'type': 'integer'}]}],
> >                'minItems': 1,
> >                'type': 'array'},
> >      'minItems': 1,
> >      'type': 'array'}
> > 
> > On instance['i2c-gpio']:
> 
> Because you use "i2c-gpio", it seems... Fix it and check if error goes away.

You are correct, the error no longer appears after I had fixed the node name.

> 
> >     {'#address-cells': [[1]],
> >      '#size-cells': [[0]],
> >      'compatible': ['i2c-gpio'],
> >      'imu@68': {'compatible': ['invensense,mpu9250'],
> >                 'i2c-gate': {'#address-cells': [[1]],
> >                              '#size-cells': [[0]],
> >                              'magnetometer@c': {'compatible': ['asahi-kasei,ak8975'],
> >                                                 'reg': [[12]]}},
> >                 'interrupt-parent': [[55]],
> >                 'interrupts': [[1, 1]],
> >                 'reg': [[104]]},
> >      'pinctrl-0': [[58]],
> >      'pinctrl-names': ['default'],
> >      'scl-gpios': [[11, 4, 6]],
> >      'sda-gpios': [[11, 5, 6]]}
> >         From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/gpio/gpio-consumer.yaml
> > 
> > > 
> > > > 
> > > > 
> > > > imx6ul-ts7553v2.dtb: spi@2010000: spidev@1: 'compatible' is a required property
> > > >   Many of our devices have open-ended I2C and SPI ports that may or may not be
> > > >   used in customer applications. With "spidev" compatible string no longer
> > > >   supported, there is no easy way we know of to leave a placeholder or
> > > >   indication that the interface is present, usable, and either needs specific
> > > >   support enabled in kernel or userspace access via /dev/. We would love
> > > >   feedback on how to handle this situation when submitting platforms upstream.
> > > 
> > > No empty devices, especially for spidev in DTS. There is really no
> > > single need to add fake spidev... really, why? The customer cannot read
> > > hardware manual and cannot see the header on the board? You can give him
> > > a tutorial/howto guide, but don't embed dead or non-real code in DTS.
> > 
> > We ship devices as bootable out of the box. A number of our customers end up
> > attaching SPI devices that do not have existing kernel drivers and talk to them
> > from userspace without having to touch a kernel build. The loss of spidev
> > directly has increased support requests we receive on the matter.
> 
> Unfortunately this is an argument like - our customers always wanted
> dead code in DTS, so we embed here such. Feel free to add a comment
> about placeholder etc, but empty node not. Another issue is that empty
> node without compatible also does not help your customers...
> 
> > 
> 
> (...)
> 
> > 
> > > 
> > > > +
> > > > +	gpio-keys {
> > > > +		compatible = "gpio-keys";
> > > > +		pinctrl-names = "default";
> > > > +		pinctrl-0 = <&pinctrl_gpio_keys>;
> > > > +
> > > > +		left {
> > > 
> > > This fails on dtbs_check. Generic node names, so "key-0" or "key-left"
> > 
> > For reference, as of commit b047602d579b4fb028128a525f056bbdc890e7f0, there
> > are no errors/warnings from dtbs_check or checkpatch.pl regarding node
> > names being "key-..." and the example in gpio-keys.yaml uses "up" "left" etc.
> 
> I know, I changed it. It's in linux-next.
> 
> > 
> > I've also changed the node name to just "keys" per devicetree specifications
> > doc.
> > 
> > > 
> > > > +	i2c_gpio: i2c-gpio {
> > > 
> > > Generic node name, so "i2c"
> > 
> > Understood.
> > 
> > Are there any guidelines/restrictions on label use/schema 
> > throughout a dts file? The devicetree-specification document only defines
> > valid characters for a label and I've been unable to find any other docs.
> 
> For label - use underscores and that's it. Only the node names should be
> generic.
> 
> > 
> 
> Best regards,
> Krzysztof
> 
