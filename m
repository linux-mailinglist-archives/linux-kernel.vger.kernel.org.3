Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E2B5A7C50
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiHaLjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiHaLj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:39:26 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3516A7A8C;
        Wed, 31 Aug 2022 04:39:24 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id t15-20020a4a96cf000000b0044e0142ec24so1192510ooi.8;
        Wed, 31 Aug 2022 04:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ENoT8reFsOMf+8JOf8cswy5o8WUg9ZyToE5d+npkpYI=;
        b=7WnPIyOjlOyZvC5cD9BHBo2ZLgEhNDDW8uJcygYDyWnKj9CvxPIsoax0duLekTv8r1
         VtI9sNPmAh5jfBnBY93pOjFlf1+ruLZ6e2+fMSyhEcip0/RRahqSa7af7G00f5d07w7Y
         Lk00YjPBj1EqUKb4n/UdRFcSisbfigc3HFOjWPKyGBZzFBeumtNeS4ti9DEXmTjYOset
         y7dGhyXAY6+0IrMnb+qSFq/4z92w4TW2eiT7JHUnor2fST5REtpn2qYPpjT95QGj3iVO
         SbkDlTfYojwX2o4TbjuOPwB95dtG2/xS5HNKYdHx2s0uSeIChTVABEAvOxo/eNFU3YC2
         bv1w==
X-Gm-Message-State: ACgBeo2vpeiDhuGUmVA7Ze8x5/ov35oLqP8InjdU2ePQ5E1sDPIrK+nS
        mfKCb+wYDxvXoY4hDu72mg==
X-Google-Smtp-Source: AA6agR4CJVxaN/hzkl1xyoGVwoSvi4EAWvazAJEP1KsptggUhPcvjk3JXAk+fe3QS35gFek/57Ta3g==
X-Received: by 2002:a4a:e68e:0:b0:44b:6ddc:42df with SMTP id u14-20020a4ae68e000000b0044b6ddc42dfmr7824425oot.62.1661945964101;
        Wed, 31 Aug 2022 04:39:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m4-20020a4ad504000000b00425678b9c4bsm8026949oos.0.2022.08.31.04.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 04:39:23 -0700 (PDT)
Received: (nullmailer pid 3614529 invoked by uid 1000);
        Wed, 31 Aug 2022 11:39:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Eliav Farber <farbere@amazon.com>
Cc:     robh+dt@kernel.org, almogbs@amazon.com, rtanwar@maxlinear.com,
        talel@amazon.com, linux-hwmon@vger.kernel.org, itamark@amazon.com,
        amitlavi@amazon.com, linux@roeck-us.net, jonnyc@amazon.com,
        p.zabel@pengutronix.de, shellykz@amazon.com, jdelvare@suse.com,
        shorer@amazon.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rahul.tanwar@linux.intel.com,
        dkl@amazon.com, hanochu@amazon.com, andriy.shevchenko@intel.com,
        hhhawa@amazon.com, ronenk@amazon.com
In-Reply-To: <20220830192212.28570-9-farbere@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com> <20220830192212.28570-9-farbere@amazon.com>
Subject: Re: [PATCH v3 08/19] dt-bindings: hwmon: (mr75203) add "moortec,vm-active-channels" property
Date:   Wed, 31 Aug 2022 06:39:21 -0500
Message-Id: <1661945961.480039.3614528.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022 19:22:01 +0000, Eliav Farber wrote:
> Add optional "moortec,vm-active-channels" property to define the number
> of active channels per VM.
> 
> This shall be useful to avoid exposing sysfs for reading inputs that are
> not connected to any voltage source.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
> V3 -> V2:
> - Add "moortec" prefix to property name.
> - Add explanation why this change is needed.
> 
>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml: error checking schema file
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml: ignoring, error in schema: properties: moortec,vm-active-channels
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/moortec,mr75203.example.dtb: pvt@e0680000: 'moortec,vm-active-channels' does not match any of the regexes: '^#.*', '^(at25|bm|devbus|dmacap|dsa|exynos|fsi[ab]|gpio-fan|gpio-key|gpio|gpmc|hdmi|i2c-gpio),.*', '^(keypad|m25p|max8952|max8997|max8998|mpmc),.*', '^(pinctrl-single|#pinctrl-single|PowerPC),.*', '^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*', '^(simple-audio-card|st-plgpio|st-spics|ts),.*', '^100ask,.*', '^70mai,.*', '^8dev,.*', '^GEFanuc,.*', '^ORCL,.*', '^SUNW,.*', '^[a-zA-Z0-9#_][a-zA-Z0-9+\\-._@]{0,63}$', '^[a-zA-Z0-9+\\-._]*@[0-9a-zA-Z,]*$', '^abb,.*', '^abilis,.*', '^abracon,.*', '^abt,.*', '^acer,.*', '^acme,.*', '^actions,.*', '^active-semi,.*', '^ad,.*', '^adafruit,.*', '^adapteva,.*', '^adaptrum,.*', '^adh,.*', '^adi,.*', '^advantech,.*', '^aeroflexgaisler,.*', '^aesop,.*', '^airoha,.*', '^al,.*', '^alcatel,.*', '^allegro,.*', '^allo,.*', '^allwinner,.*', '^alphascale,.*', '^al
 ps,.*', '^alt,.*', '^altr,.*', '^amarula,.*', '^amazon,.*', '^amcc,.*', '^amd,.*', '^amediatech,.*', '^amlogic,.*', '^ampere,.*', '^ampire,.*', '^ams,.*', '^amstaos,.*', '^analogix,.*', '^andestech,.*', '^anvo,.*', '^apm,.*', '^apple,.*', '^aptina,.*', '^arasan,.*', '^archermind,.*', '^arctic,.*', '^arcx,.*', '^aries,.*', '^arm,.*', '^armadeus,.*', '^arrow,.*', '^artesyn,.*', '^asahi-kasei,.*', '^asc,.*', '^asix,.*', '^aspeed,.*', '^asrock,.*', '^asus,.*', '^atheros,.*', '^atlas,.*', '^atmel,.*', '^auo,.*', '^auvidea,.*', '^avago,.*', '^avia,.*', '^avic,.*', '^avnet,.*', '^awinic,.*', '^axentia,.*', '^axis,.*', '^azoteq,.*', '^azw,.*', '^baikal,.*', '^bananapi,.*', '^beacon,.*', '^beagle,.*', '^bhf,.*', '^bitmain,.*', '^blutek,.*', '^boe,.*', '^bosch,.*', '^boundary,.*', '^brcm,.*', '^broadmobi,.*', '^bsh,.*', '^bticino,.*', '^buffalo,.*', '^bur,.*', '^bytedance,.*', '^calamp,.*', '^calaosystems,.*', '^calxeda,.*', '^canaan,.*', '^caninos,.*', '^capella,.*', '^cascoda,.*', '^catalys
 t,.*', '^cavium,.*', '^cdns,.*', '^cdtech,.*', '^cellwise,.*', '^ceva,.*', '^checkpoint,.*', '^chefree,.*', '^chipidea,.*', '^chipone,.*', '^chipspark,.*', '^chrontel,.*', '^chrp,.*', '^chunghwa,.*', '^chuwi,.*', '^ciaa,.*', '^cirrus,.*', '^cisco,.*', '^cloudengines,.*', '^cnm,.*', '^cnxt,.*', '^colorfly,.*', '^compulab,.*', '^congatec,.*', '^coreriver,.*', '^corpro,.*', '^cortina,.*', '^cosmic,.*', '^crane,.*', '^creative,.*', '^crystalfontz,.*', '^csky,.*', '^csq,.*', '^ctera,.*', '^ctu,.*', '^cubietech,.*', '^cui,.*', '^cypress,.*', '^cyx,.*', '^cznic,.*', '^dallas,.*', '^dataimage,.*', '^davicom,.*', '^dell,.*', '^delta,.*', '^densitron,.*', '^denx,.*', '^devantech,.*', '^dfi,.*', '^dh,.*', '^difrnce,.*', '^digi,.*', '^digilent,.*', '^dioo,.*', '^dlc,.*', '^dlg,.*', '^dlink,.*', '^dmo,.*', '^domintech,.*', '^dongwoon,.*', '^dptechnics,.*', '^dragino,.*', '^ds,.*', '^dserve,.*', '^dynaimage,.*', '^ea,.*', '^ebang,.*', '^ebbg,.*', '^ebs-systart,.*', '^ebv,.*', '^eckelmann,.*', '^e
 dimax,.*', '^edt,.*', '^eeti,.*', '^einfochips,.*', '^eink,.*', '^elan,.*', '^element14,.*', '^elgin,.*', '^elida,.*', '^elimo,.*', '^elpida,.*', '^embest,.*', '^emlid,.*', '^emmicro,.*', '^empire-electronix,.*', '^emtrion,.*', '^enclustra,.*', '^endless,.*', '^ene,.*', '^energymicro,.*', '^engicam,.*', '^engleder,.*', '^epcos,.*', '^epfl,.*', '^epson,.*', '^esp,.*', '^est,.*', '^ettus,.*', '^eukrea,.*', '^everest,.*', '^everspin,.*', '^evervision,.*', '^exar,.*', '^excito,.*', '^exegin,.*', '^ezchip,.*', '^facebook,.*', '^fairphone,.*', '^faraday,.*', '^fastrax,.*', '^fcs,.*', '^feixin,.*', '^feiyang,.*', '^fii,.*', '^firefly,.*', '^focaltech,.*', '^forlinx,.*', '^frida,.*', '^friendlyarm,.*', '^fsl,.*', '^fujitsu,.*', '^fxtec,.*', '^gardena,.*', '^gateworks,.*', '^gcw,.*', '^ge,.*', '^geekbuying,.*', '^gef,.*', '^gemei,.*', '^geniatech,.*', '^giantec,.*', '^giantplus,.*', '^globalscale,.*', '^globaltop,.*', '^gmt,.*', '^goodix,.*', '^google,.*', '^grinn,.*', '^grmn,.*', '^gumstix,
 .*', '^gw,.*', '^hannstar,.*', '^haochuangyi,.*', '^haoyu,.*', '^hardkernel,.*', '^hechuang,.*', '^hideep,.*', '^himax,.*', '^hirschmann,.*', '^hisi,.*', '^hisilicon,.*', '^hit,.*', '^hitex,.*', '^holt,.*', '^holtek,.*', '^honestar,.*', '^honeywell,.*', '^hoperun,.*', '^hp,.*', '^hpe,.*', '^hsg,.*', '^huawei,.*', '^hugsun,.*', '^hwacom,.*', '^hxt,.*', '^hycon,.*', '^hydis,.*', '^hynix,.*', '^hyundai,.*', '^i2se,.*', '^ibm,.*', '^icplus,.*', '^idt,.*', '^ifi,.*', '^ilitek,.*', '^imagis,.*', '^img,.*', '^imi,.*', '^incircuit,.*', '^inet-tek,.*', '^infineon,.*', '^inforce,.*', '^ingenic,.*', '^ingrasys,.*', '^injoinic,.*', '^innolux,.*', '^inside-secure,.*', '^insignal,.*', '^inspur,.*', '^intel,.*', '^intercontrol,.*', '^invensense,.*', '^inventec,.*', '^inversepath,.*', '^iom,.*', '^isee,.*', '^isil,.*', '^issi,.*', '^ite,.*', '^itead,.*', '^itian,.*', '^ivo,.*', '^iwave,.*', '^jdi,.*', '^jedec,.*', '^jesurun,.*', '^jethome,.*', '^jianda,.*', '^joz,.*', '^kam,.*', '^karo,.*', '^keith
 koep,.*', '^keymile,.*', '^khadas,.*', '^kiebackpeter,.*', '^kinetic,.*', '^kingdisplay,.*', '^kingnovel,.*', '^kionix,.*', '^kobo,.*', '^kobol,.*', '^koe,.*', '^kontron,.*', '^kosagi,.*', '^kvg,.*', '^kyo,.*', '^lacie,.*', '^laird,.*', '^lamobo,.*', '^lantiq,.*', '^lattice,.*', '^leadtek,.*', '^leez,.*', '^lego,.*', '^lemaker,.*', '^lenovo,.*', '^lg,.*', '^lgphilips,.*', '^libretech,.*', '^licheepi,.*', '^linaro,.*', '^linksprite,.*', '^linksys,.*', '^linutronix,.*', '^linux,.*', '^linx,.*', '^liteon,.*', '^litex,.*', '^lltc,.*', '^logicpd,.*', '^logictechno,.*', '^longcheer,.*', '^lontium,.*', '^loongson,.*', '^lsi,.*', '^lwn,.*', '^lxa,.*', '^m5stack,.*', '^macnica,.*', '^mantix,.*', '^mapleboard,.*', '^marvell,.*', '^maxbotix,.*', '^maxim,.*', '^mbvl,.*', '^mcube,.*', '^meas,.*', '^mecer,.*', '^mediatek,.*', '^megachips,.*', '^mele,.*', '^melexis,.*', '^melfas,.*', '^mellanox,.*', '^memsic,.*', '^menlo,.*', '^mentor,.*', '^meraki,.*', '^merrii,.*', '^micrel,.*', '^microchip,.*',
  '^microcrystal,.*', '^micron,.*', '^microsoft,.*', '^microsys,.*', '^mikroe,.*', '^mikrotik,.*', '^miniand,.*', '^minix,.*', '^miramems,.*', '^mitsubishi,.*', '^mixel,.*', '^miyoo,.*', '^mntre,.*', '^modtronix,.*', '^mosaixtech,.*', '^motorola,.*', '^moxa,.*', '^mpl,.*', '^mps,.*', '^mqmaker,.*', '^mrvl,.*', '^mscc,.*', '^msi,.*', '^mstar,.*', '^mti,.*', '^multi-inno,.*', '^mundoreader,.*', '^murata,.*', '^mxic,.*', '^mxicy,.*', '^myir,.*', '^national,.*', '^nec,.*', '^neonode,.*', '^netgear,.*', '^netlogic,.*', '^netron-dy,.*', '^netronix,.*', '^netxeon,.*', '^neweast,.*', '^newhaven,.*', '^nexbox,.*', '^nextthing,.*', '^ni,.*', '^nintendo,.*', '^nlt,.*', '^nokia,.*', '^nordic,.*', '^novtech,.*', '^nutsboard,.*', '^nuvoton,.*', '^nvd,.*', '^nvidia,.*', '^nxp,.*', '^oceanic,.*', '^ocs,.*', '^oct,.*', '^okaya,.*', '^oki,.*', '^olimex,.*', '^olpc,.*', '^oneplus,.*', '^onion,.*', '^onnn,.*', '^ontat,.*', '^opalkelly,.*', '^opencores,.*', '^openembed,.*', '^openrisc,.*', '^option,.*', 
 '^oranth,.*', '^orisetech,.*', '^ortustech,.*', '^osddisplays,.*', '^osmc,.*', '^ouya,.*', '^overkiz,.*', '^ovti,.*', '^oxsemi,.*', '^ozzmaker,.*', '^panasonic,.*', '^parade,.*', '^parallax,.*', '^pda,.*', '^pericom,.*', '^pervasive,.*', '^phicomm,.*', '^phytec,.*', '^picochip,.*', '^pine64,.*', '^pineriver,.*', '^pixcir,.*', '^plantower,.*', '^plathome,.*', '^plda,.*', '^plx,.*', '^ply,.*', '^pni,.*', '^pocketbook,.*', '^polaroid,.*', '^portwell,.*', '^poslab,.*', '^pov,.*', '^powertip,.*', '^powervr,.*', '^primux,.*', '^probox2,.*', '^prt,.*', '^pulsedlight,.*', '^purism,.*', '^qca,.*', '^qcom,.*', '^qemu,.*', '^qi,.*', '^qiaodian,.*', '^qihua,.*', '^qishenglong,.*', '^qnap,.*', '^quanta,.*', '^radxa,.*', '^raidsonic,.*', '^ralink,.*', '^ramtron,.*', '^raspberrypi,.*', '^raydium,.*', '^rda,.*', '^realtek,.*', '^remarkable,.*', '^renesas,.*', '^rervision,.*', '^revotics,.*', '^rex,.*', '^richtek,.*', '^ricoh,.*', '^rikomagic,.*', '^riot,.*', '^riscv,.*', '^rockchip,.*', '^rocktech,
 .*', '^rohm,.*', '^ronbo,.*', '^roofull,.*', '^roseapplepi,.*', '^samsung,.*', '^samtec,.*', '^sancloud,.*', '^sandisk,.*', '^satoz,.*', '^sbs,.*', '^schindler,.*', '^seagate,.*', '^seeed,.*', '^seirobotics,.*', '^semtech,.*', '^senseair,.*', '^sensirion,.*', '^sensortek,.*', '^sercomm,.*', '^sff,.*', '^sgd,.*', '^sgmicro,.*', '^sgx,.*', '^sharp,.*', '^shift,.*', '^shimafuji,.*', '^shiratech,.*', '^si-en,.*', '^si-linux,.*', '^siemens,.*', '^sifive,.*', '^sigma,.*', '^sii,.*', '^sil,.*', '^silabs,.*', '^silan,.*', '^silead,.*', '^silergy,.*', '^silex-insight,.*', '^siliconfile,.*', '^siliconmitus,.*', '^silvaco,.*', '^simtek,.*', '^sinlinx,.*', '^sinovoip,.*', '^sinowealth,.*', '^sipeed,.*', '^sirf,.*', '^sis,.*', '^sitronix,.*', '^skov,.*', '^skyworks,.*', '^smartlabs,.*', '^smsc,.*', '^snps,.*', '^sochip,.*', '^socionext,.*', '^solidrun,.*', '^solomon,.*', '^sony,.*', '^spansion,.*', '^sparkfun,.*', '^spinalhdl,.*', '^sprd,.*', '^ssi,.*', '^sst,.*', '^sstar,.*', '^st,.*', '^st-eri
 csson,.*', '^starfive,.*', '^starry,.*', '^startek,.*', '^ste,.*', '^stericsson,.*', '^storlink,.*', '^storm,.*', '^storopack,.*', '^summit,.*', '^sunchip,.*', '^sundance,.*', '^sunplus,.*', '^supermicro,.*', '^swir,.*', '^syna,.*', '^synology,.*', '^synopsys,.*', '^tbs,.*', '^tbs-biometrics,.*', '^tcg,.*', '^tcl,.*', '^tcs,.*', '^tdo,.*', '^team-source-display,.*', '^technexion,.*', '^technologic,.*', '^techstar,.*', '^teltonika,.*', '^tempo,.*', '^terasic,.*', '^tesla,.*', '^tfc,.*', '^thead,.*', '^thine,.*', '^thingyjp,.*', '^thundercomm,.*', '^ti,.*', '^tianma,.*', '^tlm,.*', '^tmt,.*', '^topeet,.*', '^topic,.*', '^toppoly,.*', '^topwise,.*', '^toradex,.*', '^toshiba,.*', '^toumaz,.*', '^tpk,.*', '^tplink,.*', '^tpo,.*', '^tq,.*', '^traverse,.*', '^tronfy,.*', '^tronsmart,.*', '^truly,.*', '^tsd,.*', '^tyan,.*', '^u-blox,.*', '^u-boot,.*', '^ubnt,.*', '^ucrobotics,.*', '^udoo,.*', '^ugoos,.*', '^uniwest,.*', '^upisemi,.*', '^urt,.*', '^usi,.*', '^utoo,.*', '^v3,.*', '^vaisala,.*
 ', '^vamrs,.*', '^variscite,.*', '^vdl,.*', '^vertexcom,.*', '^via,.*', '^vicor,.*', '^videostrong,.*', '^virtio,.*', '^virtual,.*', '^vishay,.*', '^visionox,.*', '^vitesse,.*', '^vivante,.*', '^vivax,.*', '^vocore,.*', '^voipac,.*', '^vot,.*', '^vxt,.*', '^wanchanglong,.*', '^wand,.*', '^waveshare,.*', '^wd,.*', '^we,.*', '^welltech,.*', '^wetek,.*', '^wexler,.*', '^whwave,.*', '^wi2wi,.*', '^wiligear,.*', '^willsemi,.*', '^winbond,.*', '^wingtech,.*', '^winlink,.*', '^winstar,.*', '^wirelesstag,.*', '^wits,.*', '^wlf,.*', '^wm,.*', '^wobo,.*', '^x-powers,.*', '^xen,.*', '^xes,.*', '^xiaomi,.*', '^xillybus,.*', '^xingbangda,.*', '^xinpeng,.*', '^xiphera,.*', '^xlnx,.*', '^xnano,.*', '^xunlong,.*', '^xylon,.*', '^yadro,.*', '^yamaha,.*', '^yes-optoelectronics,.*', '^yic,.*', '^ylm,.*', '^yna,.*', '^yones-toptech,.*', '^ys,.*', '^ysoft,.*', '^zarlink,.*', '^zealz,.*', '^zeitec,.*', '^zidoo,.*', '^zii,.*', '^zinitix,.*', '^zkmagic,.*', '^zte,.*', '^zyxel,.*', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/vendor-prefixes.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/moortec,mr75203.example.dtb: pvt@e0680000: intel,vm-map: b'\x03\x01\x04\xff\xff' is not of type 'object', 'array', 'boolean', 'null'
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/dt-core.yaml
Documentation/devicetree/bindings/hwmon/moortec,mr75203.example.dtb:0:0: /example-0/pvt@e0680000: failed to match any schema with compatible: ['moortec,mr75203']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

