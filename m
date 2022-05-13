Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C560152637A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiEMOMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiEMOMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:12:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF1711B407;
        Fri, 13 May 2022 07:12:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EC29ACE31D0;
        Fri, 13 May 2022 14:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C3FC36AE2;
        Fri, 13 May 2022 14:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652451136;
        bh=HH8tNT9tiA04dQ017qbO5zw1boylBuCKHFJ18ZzpEak=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Eib47AkMoPF7BqMS44TXNr/Sb5I8nP9hWEW6zRqn4kgspquC20kYTnbleoo8k9y7T
         +vnVjOmzZ8wqn3u3gEeurUvpAXXjeSip1CmmN6tUc17tazWrj5HYk+YGDHxkHgx6T1
         oCC99JK/rLK22zA3ZxSGOpWKvKvYaZwww6KEg1nsSdZdaEhAIAro9RpTHrFb1ZeKLt
         72wMfCtEykfYU7Yg8jrCOQENE6Bgj21L8wsgbR1MrqHD6Zj67qNOvZJHCzBAlR2H35
         +btUXJqjS95dm/IgPPj6yT99QDPQpP5NoTneduoPqPyERVUbZMTy5GTP+Xmt9bVNG4
         XEdQpVMQ8qbwg==
Received: by mail-pl1-f175.google.com with SMTP id d17so8096565plg.0;
        Fri, 13 May 2022 07:12:16 -0700 (PDT)
X-Gm-Message-State: AOAM530VEaJnGtkzkRTuvxGQeBOvFbmRDMfg7990yOBfpYUlQR7rYqYo
        wOk11ooH8l5YdUsEQREtisObhCRhv+bXqJL7NA==
X-Google-Smtp-Source: ABdhPJzGHUonLHvG6hKoTi4AF+1mrFCq3b0a+Wh3ckhTTSIpB3yo+xQVszOl5Lgx7P2zMAIOmB1dmkCFkM2VM4GaRz0=
X-Received: by 2002:a17:90a:fd83:b0:1de:d6fd:d552 with SMTP id
 cx3-20020a17090afd8300b001ded6fdd552mr10599841pjb.32.1652451135585; Fri, 13
 May 2022 07:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220503155007.2339847-1-csharper2005@gmail.com> <20220512152725.244872-1-miquel.raynal@bootlin.com>
In-Reply-To: <20220512152725.244872-1-miquel.raynal@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 13 May 2022 09:12:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJdUm4p9qAq9dLeVTVC9PA2q2SP01kG2jyEb_f=Fo=bEQ@mail.gmail.com>
Message-ID: <CAL_JsqJdUm4p9qAq9dLeVTVC9PA2q2SP01kG2jyEb_f=Fo=bEQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: mtd: partitions: Extend
 fixed-partitions binding
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Karim <Karimdplay@gmail.com>, M <x1@disroot.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 10:27 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> On Tue, 2022-05-03 at 15:50:07 UTC, Mikhail Zhilkin wrote:
> > Extend fixed-partitions binding for support of Sercomm partition parser
> > (add "sercomm,sc-partitions" compatible).
> >
> > Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Patch 1 is a dependency, please apply it too. Without it, we now get
in linux-next:

/builds/robherring/linux-dt/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.example.dtb:
partition@0: 'sercomm,scpart-id' does not match any of the regexes:
'^#.*', '^(at25|bm|devbus|dmacap|dsa|exynos|fsi[ab]|gpio-fan|gpio-key|gpio|gpmc|hdmi|i2c-gpio),.*',
'^(keypad|m25p|max8952|max8997|max8998|mpmc),.*',
'^(pinctrl-single|#pinctrl-single|PowerPC),.*',
'^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*',
'^(simple-audio-card|st-plgpio|st-spics|ts),.*', '^100ask,.*',
'^70mai,.*', '^8dev,.*', '^GEFanuc,.*', '^ORCL,.*', '^SUNW,.*',
'^[a-zA-Z0-9#_][a-zA-Z0-9+\\-._@]{0,63}$',
'^[a-zA-Z0-9+\\-._]*@[0-9a-zA-Z,]*$', '^abb,.*', '^abilis,.*',
'^abracon,.*', '^abt,.*', '^acer,.*', '^acme,.*', '^actions,.*',
'^active-semi,.*', '^ad,.*', '^adafruit,.*', '^adapteva,.*',
'^adaptrum,.*', '^adh,.*', '^adi,.*', '^advantech,.*',
'^aeroflexgaisler,.*', '^aesop,.*', '^airoha,.*', '^al,.*',
'^alcatel,.*', '^allegro,.*', '^allo,.*', '^allwinner,.*',
'^alphascale,.*', '^alps,.*', '^alt,.*', '^altr,.*', '^amarula,.*',
'^amazon,.*', '^amcc,.*', '^amd,.*', '^amediatech,.*', '^amlogic,.*',
'^ampere,.*', '^ampire,.*', '^ams,.*', '^amstaos,.*', '^analogix,.*',
'^andestech,.*', '^anvo,.*', '^apm,.*', '^apple,.*', '^aptina,.*',
'^arasan,.*', '^archermind,.*', '^arctic,.*', '^arcx,.*', '^aries,.*',
'^arm,.*', '^armadeus,.*', '^arrow,.*', '^artesyn,.*',
'^asahi-kasei,.*', '^asc,.*', '^asix,.*', '^aspeed,.*', '^asus,.*',
'^atlas,.*', '^atmel,.*', '^auo,.*', '^auvidea,.*', '^avago,.*',
'^avia,.*', '^avic,.*', '^avnet,.*', '^awinic,.*', '^axentia,.*',
'^axis,.*', '^azoteq,.*', '^azw,.*', '^baikal,.*', '^bananapi,.*',
'^beacon,.*', '^beagle,.*', '^bhf,.*', '^bitmain,.*', '^blutek,.*',
'^boe,.*', '^bosch,.*', '^boundary,.*', '^brcm,.*', '^broadmobi,.*',
'^bsh,.*', '^bticino,.*', '^buffalo,.*', '^bur,.*', '^calamp,.*',
'^calaosystems,.*', '^calxeda,.*', '^canaan,.*', '^caninos,.*',
'^capella,.*', '^cascoda,.*', '^catalyst,.*', '^cavium,.*',
'^cdns,.*', '^cdtech,.*', '^cellwise,.*', '^ceva,.*',
'^checkpoint,.*', '^chefree,.*', '^chipidea,.*', '^chipone,.*',
'^chipspark,.*', '^chrontel,.*', '^chrp,.*', '^chunghwa,.*',
'^chuwi,.*', '^ciaa,.*', '^cirrus,.*', '^cisco,.*',
'^cloudengines,.*', '^cnm,.*', '^cnxt,.*', '^colorfly,.*',
'^compulab,.*', '^congatec,.*', '^coreriver,.*', '^corpro,.*',
'^cortina,.*', '^cosmic,.*', '^crane,.*', '^creative,.*',
'^crystalfontz,.*', '^csky,.*', '^csq,.*', '^ctera,.*', '^ctu,.*',
'^cubietech,.*', '^cui,.*', '^cypress,.*', '^cyx,.*', '^cznic,.*',
'^dallas,.*', '^dataimage,.*', '^davicom,.*', '^dell,.*', '^delta,.*',
'^denx,.*', '^devantech,.*', '^dfi,.*', '^dh,.*', '^difrnce,.*',
'^digi,.*', '^digilent,.*', '^dioo,.*', '^dlc,.*', '^dlg,.*',
'^dlink,.*', '^dmo,.*', '^domintech,.*', '^dongwoon,.*',
'^dptechnics,.*', '^dragino,.*', '^ds,.*', '^dserve,.*',
'^dynaimage,.*', '^ea,.*', '^ebang,.*', '^ebs-systart,.*', '^ebv,.*',
'^eckelmann,.*', '^edimax,.*', '^edt,.*', '^eeti,.*',
'^einfochips,.*', '^eink,.*', '^elan,.*', '^element14,.*',
'^elgin,.*', '^elida,.*', '^elimo,.*', '^elpida,.*', '^embest,.*',
'^emlid,.*', '^emmicro,.*', '^empire-electronix,.*', '^emtrion,.*',
'^enclustra,.*', '^endless,.*', '^ene,.*', '^energymicro,.*',
'^engicam,.*', '^engleder,.*', '^epcos,.*', '^epfl,.*', '^epson,.*',
'^esp,.*', '^est,.*', '^ettus,.*', '^eukrea,.*', '^everest,.*',
'^everspin,.*', '^evervision,.*', '^exar,.*', '^excito,.*',
'^exegin,.*', '^ezchip,.*', '^facebook,.*', '^fairphone,.*',
'^faraday,.*', '^fastrax,.*', '^fcs,.*', '^feixin,.*', '^feiyang,.*',
'^fii,.*', '^firefly,.*', '^focaltech,.*', '^forlinx,.*', '^frida,.*',
'^friendlyarm,.*', '^fsl,.*', '^fujitsu,.*', '^fxtec,.*',
'^gardena,.*', '^gateworks,.*', '^gcw,.*', '^ge,.*', '^geekbuying,.*',
'^gef,.*', '^gemei,.*', '^geniatech,.*', '^giantec,.*',
'^giantplus,.*', '^globalscale,.*', '^globaltop,.*', '^gmt,.*',
'^goodix,.*', '^google,.*', '^grinn,.*', '^grmn,.*', '^gumstix,.*',
'^gw,.*', '^hannstar,.*', '^haochuangyi,.*', '^haoyu,.*',
'^hardkernel,.*', '^hideep,.*', '^himax,.*', '^hirschmann,.*',
'^hisi,.*', '^hisilicon,.*', '^hit,.*', '^hitex,.*', '^holt,.*',
'^holtek,.*', '^honestar,.*', '^honeywell,.*', '^hoperun,.*',
'^hp,.*', '^hpe,.*', '^hsg,.*', '^huawei,.*', '^hugsun,.*',
'^hwacom,.*', '^hycon,.*', '^hydis,.*', '^hynix,.*', '^hyundai,.*',
'^i2se,.*', '^ibm,.*', '^icplus,.*', '^idt,.*', '^ifi,.*',
'^ilitek,.*', '^imagis,.*', '^img,.*', '^imi,.*', '^incircuit,.*',
'^inet-tek,.*', '^infineon,.*', '^inforce,.*', '^ingenic,.*',
'^injoinic,.*', '^innolux,.*', '^inside-secure,.*', '^insignal,.*',
'^inspur,.*', '^intel,.*', '^intercontrol,.*', '^invensense,.*',
'^inversepath,.*', '^iom,.*', '^isee,.*', '^isil,.*', '^issi,.*',
'^ite,.*', '^itead,.*', '^itian,.*', '^ivo,.*', '^iwave,.*',
'^jdi,.*', '^jedec,.*', '^jesurun,.*', '^jethome,.*', '^jianda,.*',
'^joz,.*', '^kam,.*', '^karo,.*', '^keithkoep,.*', '^keymile,.*',
'^khadas,.*', '^kiebackpeter,.*', '^kinetic,.*', '^kingdisplay,.*',
'^kingnovel,.*', '^kionix,.*', '^kobo,.*', '^kobol,.*', '^koe,.*',
'^kontron,.*', '^kosagi,.*', '^kvg,.*', '^kyo,.*', '^lacie,.*',
'^laird,.*', '^lamobo,.*', '^lantiq,.*', '^lattice,.*', '^leadtek,.*',
'^leez,.*', '^lego,.*', '^lemaker,.*', '^lenovo,.*', '^lg,.*',
'^lgphilips,.*', '^libretech,.*', '^licheepi,.*', '^linaro,.*',
'^linksprite,.*', '^linksys,.*', '^linutronix,.*', '^linux,.*',
'^linx,.*', '^liteon,.*', '^litex,.*', '^lltc,.*', '^logicpd,.*',
'^logictechno,.*', '^longcheer,.*', '^lontium,.*', '^loongson,.*',
'^lsi,.*', '^lwn,.*', '^lxa,.*', '^m5stack,.*', '^macnica,.*',
'^mantix,.*', '^mapleboard,.*', '^marvell,.*', '^maxbotix,.*',
'^maxim,.*', '^mbvl,.*', '^mcube,.*', '^meas,.*', '^mecer,.*',
'^mediatek,.*', '^megachips,.*', '^mele,.*', '^melexis,.*',
'^melfas,.*', '^mellanox,.*', '^memsic,.*', '^menlo,.*', '^mentor,.*',
'^meraki,.*', '^merrii,.*', '^micrel,.*', '^microchip,.*',
'^microcrystal,.*', '^micron,.*', '^microsoft,.*', '^microsys,.*',
'^mikroe,.*', '^mikrotik,.*', '^miniand,.*', '^minix,.*',
'^miramems,.*', '^mitsubishi,.*', '^miyoo,.*', '^mntre,.*',
'^modtronix,.*', '^mosaixtech,.*', '^motorola,.*', '^moxa,.*',
'^mpl,.*', '^mps,.*', '^mqmaker,.*', '^mrvl,.*', '^mscc,.*',
'^msi,.*', '^mstar,.*', '^mti,.*', '^multi-inno,.*',
'^mundoreader,.*', '^murata,.*', '^mxic,.*', '^mxicy,.*', '^myir,.*',
'^national,.*', '^nec,.*', '^neonode,.*', '^netgear,.*',
'^netlogic,.*', '^netron-dy,.*', '^netronix,.*', '^netxeon,.*',
'^neweast,.*', '^newhaven,.*', '^nexbox,.*', '^nextthing,.*',
'^ni,.*', '^nintendo,.*', '^nlt,.*', '^nokia,.*', '^nordic,.*',
'^novtech,.*', '^nutsboard,.*', '^nuvoton,.*', '^nvd,.*',
'^nvidia,.*', '^nxp,.*', '^oceanic,.*', '^ocs,.*', '^oct,.*',
'^okaya,.*', '^oki,.*', '^olimex,.*', '^olpc,.*', '^oneplus,.*',
'^onion,.*', '^onnn,.*', '^ontat,.*', '^opalkelly,.*',
'^opencores,.*', '^openembed,.*', '^openrisc,.*', '^option,.*',
'^oranth,.*', '^orisetech,.*', '^ortustech,.*', '^osddisplays,.*',
'^osmc,.*', '^ouya,.*', '^overkiz,.*', '^ovti,.*', '^oxsemi,.*',
'^ozzmaker,.*', '^panasonic,.*', '^parade,.*', '^parallax,.*',
'^pda,.*', '^pericom,.*', '^pervasive,.*', '^phicomm,.*',
'^phytec,.*', '^picochip,.*', '^pine64,.*', '^pineriver,.*',
'^pixcir,.*', '^plantower,.*', '^plathome,.*', '^plda,.*', '^plx,.*',
'^ply,.*', '^pni,.*', '^pocketbook,.*', '^polaroid,.*',
'^portwell,.*', '^poslab,.*', '^pov,.*', '^powertip,.*',
'^powervr,.*', '^primux,.*', '^probox2,.*', '^prt,.*',
'^pulsedlight,.*', '^purism,.*', '^qca,.*', '^qcom,.*', '^qemu,.*',
'^qi,.*', '^qiaodian,.*', '^qihua,.*', '^qishenglong,.*', '^qnap,.*',
'^radxa,.*', '^raidsonic,.*', '^ralink,.*', '^ramtron,.*',
'^raspberrypi,.*', '^raydium,.*', '^rda,.*', '^realtek,.*',
'^remarkable,.*', '^renesas,.*', '^rervision,.*', '^revotics,.*',
'^rex,.*', '^richtek,.*', '^ricoh,.*', '^rikomagic,.*', '^riot,.*',
'^riscv,.*', '^rockchip,.*', '^rocktech,.*', '^rohm,.*', '^ronbo,.*',
'^roofull,.*', '^roseapplepi,.*', '^samsung,.*', '^samtec,.*',
'^sancloud,.*', '^sandisk,.*', '^satoz,.*', '^sbs,.*',
'^schindler,.*', '^seagate,.*', '^seeed,.*', '^seirobotics,.*',
'^semtech,.*', '^senseair,.*', '^sensirion,.*', '^sensortek,.*',
'^sff,.*', '^sgd,.*', '^sgmicro,.*', '^sgx,.*', '^sharp,.*',
'^shimafuji,.*', '^shiratech,.*', '^si-en,.*', '^si-linux,.*',
'^siemens,.*', '^sifive,.*', '^sigma,.*', '^sii,.*', '^sil,.*',
'^silabs,.*', '^silan,.*', '^silead,.*', '^silergy,.*',
'^silex-insight,.*', '^siliconfile,.*', '^siliconmitus,.*',
'^silvaco,.*', '^simtek,.*', '^sinlinx,.*', '^sinovoip,.*',
'^sinowealth,.*', '^sipeed,.*', '^sirf,.*', '^sis,.*', '^sitronix,.*',
'^skov,.*', '^skyworks,.*', '^smartlabs,.*', '^smsc,.*', '^snps,.*',
'^sochip,.*', '^socionext,.*', '^solidrun,.*', '^solomon,.*',
'^sony,.*', '^spansion,.*', '^sparkfun,.*', '^spinalhdl,.*',
'^sprd,.*', '^ssi,.*', '^sst,.*', '^sstar,.*', '^st,.*',
'^st-ericsson,.*', '^starfive,.*', '^starry,.*', '^startek,.*',
'^ste,.*', '^stericsson,.*', '^storlink,.*', '^storm,.*',
'^storopack,.*', '^summit,.*', '^sunchip,.*', '^sunplus,.*',
'^supermicro,.*', '^swir,.*', '^syna,.*', '^synology,.*',
'^synopsys,.*', '^tbs,.*', '^tbs-biometrics,.*', '^tcg,.*', '^tcl,.*',
'^tcs,.*', '^tdo,.*', '^team-source-display,.*', '^technexion,.*',
'^technologic,.*', '^techstar,.*', '^teltonika,.*', '^tempo,.*',
'^terasic,.*', '^tesla,.*', '^tfc,.*', '^thead,.*', '^thine,.*',
'^thingyjp,.*', '^thundercomm,.*', '^ti,.*', '^tianma,.*', '^tlm,.*',
'^tmt,.*', '^topeet,.*', '^topic,.*', '^toppoly,.*', '^topwise,.*',
'^toradex,.*', '^toshiba,.*', '^toumaz,.*', '^tpk,.*', '^tplink,.*',
'^tpo,.*', '^tq,.*', '^traverse,.*', '^tronfy,.*', '^tronsmart,.*',
'^truly,.*', '^tsd,.*', '^tyan,.*', '^u-blox,.*', '^u-boot,.*',
'^ubnt,.*', '^ucrobotics,.*', '^udoo,.*', '^ugoos,.*', '^uniwest,.*',
'^upisemi,.*', '^urt,.*', '^usi,.*', '^utoo,.*', '^v3,.*',
'^vaisala,.*', '^vamrs,.*', '^variscite,.*', '^vdl,.*',
'^vertexcom,.*', '^via,.*', '^vicor,.*', '^videostrong,.*',
'^virtio,.*', '^virtual,.*', '^vishay,.*', '^visionox,.*',
'^vitesse,.*', '^vivante,.*', '^vivax,.*', '^vocore,.*', '^voipac,.*',
'^vot,.*', '^vxt,.*', '^wanchanglong,.*', '^wand,.*', '^waveshare,.*',
'^wd,.*', '^we,.*', '^welltech,.*', '^wetek,.*', '^wexler,.*',
'^whwave,.*', '^wi2wi,.*', '^wiligear,.*', '^willsemi,.*',
'^winbond,.*', '^wingtech,.*', '^winlink,.*', '^winstar,.*',
'^wirelesstag,.*', '^wits,.*', '^wlf,.*', '^wm,.*', '^wobo,.*',
'^x-powers,.*', '^xen,.*', '^xes,.*', '^xiaomi,.*', '^xillybus,.*',
'^xingbangda,.*', '^xinpeng,.*', '^xiphera,.*', '^xlnx,.*',
'^xnano,.*', '^xunlong,.*', '^xylon,.*', '^yadro,.*', '^yamaha,.*',
'^yes-optoelectronics,.*', '^yic,.*', '^ylm,.*', '^yna,.*',
'^yones-toptech,.*', '^ys,.*', '^ysoft,.*', '^zarlink,.*',
'^zealz,.*', '^zeitec,.*', '^zidoo,.*', '^zii,.*', '^zinitix,.*',
'^zkmagic,.*', '^zte,.*', '^zyxel,.*'
  From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/vendor-prefixes.yaml

Rob
