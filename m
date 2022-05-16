Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198E65288F3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245302AbiEPPeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiEPPeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:34:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A945B3C700;
        Mon, 16 May 2022 08:34:42 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r188-20020a1c44c5000000b003946c466c17so8508829wma.4;
        Mon, 16 May 2022 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dvnPakmsMo/0Cz+/yM3pJBApEpZv1rHngihMkO3MXcU=;
        b=qAlkVzL/1dNyQ0WWaw0zDj/OWOlQJ6tl3JLkf8Qu0Fn9lW5KLXlYd0qKGAi5WIHwCq
         6J+Tgye0oSNiW/LVc8OkAbivNmP3/3V+S/4hc34e7y4tG9lElOhrhz1SbrgWPzv4HZx5
         MEno2LAxiLBF9qMEt+I2lOSWF2dOGDzdHpTUlxcyLF03BR/ii+JVEjAwrtjBAK6zORAd
         3wxGTvW3oDz/Sq/T7QwkgSud/BzKLeZP/oLa9m2CCuRcYbXwbAAfHcAwtGgNnZzjlvYr
         SDNcTVGzNa3ot1xCZw58iC4LuhFzA/rXtv1JuSAN0inPf16pn5MNx7BVBBQ0AfXlB+t6
         NAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dvnPakmsMo/0Cz+/yM3pJBApEpZv1rHngihMkO3MXcU=;
        b=qcV/lsVoLj7FApyMFsOraEbesssrZyI66KuO429fS4iPsxManxfRmzmU8D3YCMyTaY
         iuJbx+jTAHIrCGH0K+7XmhV9qx+6YgtlefeLjP3zekXw7UJjfU4aDUwFOGtit69NfBxA
         WCfFEk9aNGvNzbTsA3BoHfWnYhhrhpinOgf2dqXVvdkHocKqSWzig19JWbe7B7u2gcum
         /iOhbclGY23SbHwfHFm16V3IfeoVPIXOGd/H9O4obIfYUnjJ/jKyukQchiZmDpe+dnfD
         Pox0G9CLvd4MP6JYqQQXphVwc/M7+bhxiFUpD6tggzrHKHJJ8VYjIWpENMaIgags9yLC
         9miw==
X-Gm-Message-State: AOAM5320h8WT54Os2YwVbrFrGOdsOziCcHhyq6nzvAhYCBeH3nFjbTe4
        6mcQCx1m7G48SfO8fE9B1lU=
X-Google-Smtp-Source: ABdhPJxE7amQc+bTsGChbD41tG1AHVQiTbVWCGwLazfRL3iNbFh39QdGHizf3ts8FpirhNeF3Utwkw==
X-Received: by 2002:a7b:c5d0:0:b0:355:482a:6f44 with SMTP id n16-20020a7bc5d0000000b00355482a6f44mr17190339wmk.58.1652715281201;
        Mon, 16 May 2022 08:34:41 -0700 (PDT)
Received: from ?IPV6:2a06:a003:501a:a7ce:d8e8:5460:7d14:efce? ([2a06:a003:501a:a7ce:d8e8:5460:7d14:efce])
        by smtp.gmail.com with ESMTPSA id l18-20020adfb112000000b0020c5253d8d3sm9748839wra.31.2022.05.16.08.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 08:34:40 -0700 (PDT)
Message-ID: <ed853a8c-f1a5-d137-e2bb-df782d43b65e@gmail.com>
Date:   Mon, 16 May 2022 18:34:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 2/3] dt-bindings: mtd: partitions: Extend
 fixed-partitions binding
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Karim <Karimdplay@gmail.com>, M <x1@disroot.org>
References: <20220503155007.2339847-1-csharper2005@gmail.com>
 <20220512152725.244872-1-miquel.raynal@bootlin.com>
 <CAL_JsqJdUm4p9qAq9dLeVTVC9PA2q2SP01kG2jyEb_f=Fo=bEQ@mail.gmail.com>
 <20220516102115.4ab6fada@xps13>
From:   Mikhail Zhilkin <csharper2005@gmail.com>
In-Reply-To: <20220516102115.4ab6fada@xps13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Miquel!

On 5/16/2022 11:21 AM, Miquel Raynal wrote:
> Hi,
>
> robh+dt@kernel.org wrote on Fri, 13 May 2022 09:12:03 -0500:
>
>> On Thu, May 12, 2022 at 10:27 AM Miquel Raynal
>> <miquel.raynal@bootlin.com> wrote:
>>> On Tue, 2022-05-03 at 15:50:07 UTC, Mikhail Zhilkin wrote:  
>>>> Extend fixed-partitions binding for support of Sercomm partition parser
>>>> (add "sercomm,sc-partitions" compatible).
>>>>
>>>> Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>  
>>> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.  
>> Patch 1 is a dependency, please apply it too. Without it, we now get
>> in linux-next:
> Only patch 3 was sent to me/the mtd ML. I'll drop the patch.
>
> Mikhail, please resend the series including us on all your patches.

Done! I sent the series to you and mtd
https://lore.kernel.org/linux-mtd/20220516151228.885222-1-csharper2005@gmail.com/T/#t

P.S. get_maintainer.pl didn't recommend to add you and mtd that and this
time. Do I need to send each patch from the series to all maintainers of
all the patches in the future?

$ scripts/get_maintainer.pl
v5-0001-dt-bindings-Add-Sercomm-Suzhou-Corporation-vendor.patch
Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED
DEVICE TREE BINDINGS,commit_signer:59/65=91%,in file)
Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN
FIRMWARE AND FLATTENED DEVICE TREE
BINDINGS,commit_signer:12/65=18%,added_lines:7/139=5%,removed_lines:1/2=50%)
Shawn Guo <shawnguo@kernel.org> (commit_signer:7/65=11%)
Stanislav Jakubek <stano.jakubek@gmail.com>
(commit_signer:6/65=9%,authored:6/65=9%,added_lines:12/139=9%)
Sam Ravnborg <sam@ravnborg.org> (commit_signer:5/65=8%)
Linus Walleij <linus.walleij@linaro.org> (added_lines:10/139=7%)
Hao Fang <fanghao11@huawei.com> (removed_lines:1/2=50%)
devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE
TREE BINDINGS)
linux-kernel@vger.kernel.org (open list)

>> /builds/robherring/linux-dt/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.example.dtb:
>> partition@0: 'sercomm,scpart-id' does not match any of the regexes:
>> '^#.*', '^(at25|bm|devbus|dmacap|dsa|exynos|fsi[ab]|gpio-fan|gpio-key|gpio|gpmc|hdmi|i2c-gpio),.*',
>> '^(keypad|m25p|max8952|max8997|max8998|mpmc),.*',
>> '^(pinctrl-single|#pinctrl-single|PowerPC),.*',
>> '^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*',
>> '^(simple-audio-card|st-plgpio|st-spics|ts),.*', '^100ask,.*',
>> '^70mai,.*', '^8dev,.*', '^GEFanuc,.*', '^ORCL,.*', '^SUNW,.*',
>> '^[a-zA-Z0-9#_][a-zA-Z0-9+\\-._@]{0,63}$',
>> '^[a-zA-Z0-9+\\-._]*@[0-9a-zA-Z,]*$', '^abb,.*', '^abilis,.*',
>> '^abracon,.*', '^abt,.*', '^acer,.*', '^acme,.*', '^actions,.*',
>> '^active-semi,.*', '^ad,.*', '^adafruit,.*', '^adapteva,.*',
>> '^adaptrum,.*', '^adh,.*', '^adi,.*', '^advantech,.*',
>> '^aeroflexgaisler,.*', '^aesop,.*', '^airoha,.*', '^al,.*',
>> '^alcatel,.*', '^allegro,.*', '^allo,.*', '^allwinner,.*',
>> '^alphascale,.*', '^alps,.*', '^alt,.*', '^altr,.*', '^amarula,.*',
>> '^amazon,.*', '^amcc,.*', '^amd,.*', '^amediatech,.*', '^amlogic,.*',
>> '^ampere,.*', '^ampire,.*', '^ams,.*', '^amstaos,.*', '^analogix,.*',
>> '^andestech,.*', '^anvo,.*', '^apm,.*', '^apple,.*', '^aptina,.*',
>> '^arasan,.*', '^archermind,.*', '^arctic,.*', '^arcx,.*', '^aries,.*',
>> '^arm,.*', '^armadeus,.*', '^arrow,.*', '^artesyn,.*',
>> '^asahi-kasei,.*', '^asc,.*', '^asix,.*', '^aspeed,.*', '^asus,.*',
>> '^atlas,.*', '^atmel,.*', '^auo,.*', '^auvidea,.*', '^avago,.*',
>> '^avia,.*', '^avic,.*', '^avnet,.*', '^awinic,.*', '^axentia,.*',
>> '^axis,.*', '^azoteq,.*', '^azw,.*', '^baikal,.*', '^bananapi,.*',
>> '^beacon,.*', '^beagle,.*', '^bhf,.*', '^bitmain,.*', '^blutek,.*',
>> '^boe,.*', '^bosch,.*', '^boundary,.*', '^brcm,.*', '^broadmobi,.*',
>> '^bsh,.*', '^bticino,.*', '^buffalo,.*', '^bur,.*', '^calamp,.*',
>> '^calaosystems,.*', '^calxeda,.*', '^canaan,.*', '^caninos,.*',
>> '^capella,.*', '^cascoda,.*', '^catalyst,.*', '^cavium,.*',
>> '^cdns,.*', '^cdtech,.*', '^cellwise,.*', '^ceva,.*',
>> '^checkpoint,.*', '^chefree,.*', '^chipidea,.*', '^chipone,.*',
>> '^chipspark,.*', '^chrontel,.*', '^chrp,.*', '^chunghwa,.*',
>> '^chuwi,.*', '^ciaa,.*', '^cirrus,.*', '^cisco,.*',
>> '^cloudengines,.*', '^cnm,.*', '^cnxt,.*', '^colorfly,.*',
>> '^compulab,.*', '^congatec,.*', '^coreriver,.*', '^corpro,.*',
>> '^cortina,.*', '^cosmic,.*', '^crane,.*', '^creative,.*',
>> '^crystalfontz,.*', '^csky,.*', '^csq,.*', '^ctera,.*', '^ctu,.*',
>> '^cubietech,.*', '^cui,.*', '^cypress,.*', '^cyx,.*', '^cznic,.*',
>> '^dallas,.*', '^dataimage,.*', '^davicom,.*', '^dell,.*', '^delta,.*',
>> '^denx,.*', '^devantech,.*', '^dfi,.*', '^dh,.*', '^difrnce,.*',
>> '^digi,.*', '^digilent,.*', '^dioo,.*', '^dlc,.*', '^dlg,.*',
>> '^dlink,.*', '^dmo,.*', '^domintech,.*', '^dongwoon,.*',
>> '^dptechnics,.*', '^dragino,.*', '^ds,.*', '^dserve,.*',
>> '^dynaimage,.*', '^ea,.*', '^ebang,.*', '^ebs-systart,.*', '^ebv,.*',
>> '^eckelmann,.*', '^edimax,.*', '^edt,.*', '^eeti,.*',
>> '^einfochips,.*', '^eink,.*', '^elan,.*', '^element14,.*',
>> '^elgin,.*', '^elida,.*', '^elimo,.*', '^elpida,.*', '^embest,.*',
>> '^emlid,.*', '^emmicro,.*', '^empire-electronix,.*', '^emtrion,.*',
>> '^enclustra,.*', '^endless,.*', '^ene,.*', '^energymicro,.*',
>> '^engicam,.*', '^engleder,.*', '^epcos,.*', '^epfl,.*', '^epson,.*',
>> '^esp,.*', '^est,.*', '^ettus,.*', '^eukrea,.*', '^everest,.*',
>> '^everspin,.*', '^evervision,.*', '^exar,.*', '^excito,.*',
>> '^exegin,.*', '^ezchip,.*', '^facebook,.*', '^fairphone,.*',
>> '^faraday,.*', '^fastrax,.*', '^fcs,.*', '^feixin,.*', '^feiyang,.*',
>> '^fii,.*', '^firefly,.*', '^focaltech,.*', '^forlinx,.*', '^frida,.*',
>> '^friendlyarm,.*', '^fsl,.*', '^fujitsu,.*', '^fxtec,.*',
>> '^gardena,.*', '^gateworks,.*', '^gcw,.*', '^ge,.*', '^geekbuying,.*',
>> '^gef,.*', '^gemei,.*', '^geniatech,.*', '^giantec,.*',
>> '^giantplus,.*', '^globalscale,.*', '^globaltop,.*', '^gmt,.*',
>> '^goodix,.*', '^google,.*', '^grinn,.*', '^grmn,.*', '^gumstix,.*',
>> '^gw,.*', '^hannstar,.*', '^haochuangyi,.*', '^haoyu,.*',
>> '^hardkernel,.*', '^hideep,.*', '^himax,.*', '^hirschmann,.*',
>> '^hisi,.*', '^hisilicon,.*', '^hit,.*', '^hitex,.*', '^holt,.*',
>> '^holtek,.*', '^honestar,.*', '^honeywell,.*', '^hoperun,.*',
>> '^hp,.*', '^hpe,.*', '^hsg,.*', '^huawei,.*', '^hugsun,.*',
>> '^hwacom,.*', '^hycon,.*', '^hydis,.*', '^hynix,.*', '^hyundai,.*',
>> '^i2se,.*', '^ibm,.*', '^icplus,.*', '^idt,.*', '^ifi,.*',
>> '^ilitek,.*', '^imagis,.*', '^img,.*', '^imi,.*', '^incircuit,.*',
>> '^inet-tek,.*', '^infineon,.*', '^inforce,.*', '^ingenic,.*',
>> '^injoinic,.*', '^innolux,.*', '^inside-secure,.*', '^insignal,.*',
>> '^inspur,.*', '^intel,.*', '^intercontrol,.*', '^invensense,.*',
>> '^inversepath,.*', '^iom,.*', '^isee,.*', '^isil,.*', '^issi,.*',
>> '^ite,.*', '^itead,.*', '^itian,.*', '^ivo,.*', '^iwave,.*',
>> '^jdi,.*', '^jedec,.*', '^jesurun,.*', '^jethome,.*', '^jianda,.*',
>> '^joz,.*', '^kam,.*', '^karo,.*', '^keithkoep,.*', '^keymile,.*',
>> '^khadas,.*', '^kiebackpeter,.*', '^kinetic,.*', '^kingdisplay,.*',
>> '^kingnovel,.*', '^kionix,.*', '^kobo,.*', '^kobol,.*', '^koe,.*',
>> '^kontron,.*', '^kosagi,.*', '^kvg,.*', '^kyo,.*', '^lacie,.*',
>> '^laird,.*', '^lamobo,.*', '^lantiq,.*', '^lattice,.*', '^leadtek,.*',
>> '^leez,.*', '^lego,.*', '^lemaker,.*', '^lenovo,.*', '^lg,.*',
>> '^lgphilips,.*', '^libretech,.*', '^licheepi,.*', '^linaro,.*',
>> '^linksprite,.*', '^linksys,.*', '^linutronix,.*', '^linux,.*',
>> '^linx,.*', '^liteon,.*', '^litex,.*', '^lltc,.*', '^logicpd,.*',
>> '^logictechno,.*', '^longcheer,.*', '^lontium,.*', '^loongson,.*',
>> '^lsi,.*', '^lwn,.*', '^lxa,.*', '^m5stack,.*', '^macnica,.*',
>> '^mantix,.*', '^mapleboard,.*', '^marvell,.*', '^maxbotix,.*',
>> '^maxim,.*', '^mbvl,.*', '^mcube,.*', '^meas,.*', '^mecer,.*',
>> '^mediatek,.*', '^megachips,.*', '^mele,.*', '^melexis,.*',
>> '^melfas,.*', '^mellanox,.*', '^memsic,.*', '^menlo,.*', '^mentor,.*',
>> '^meraki,.*', '^merrii,.*', '^micrel,.*', '^microchip,.*',
>> '^microcrystal,.*', '^micron,.*', '^microsoft,.*', '^microsys,.*',
>> '^mikroe,.*', '^mikrotik,.*', '^miniand,.*', '^minix,.*',
>> '^miramems,.*', '^mitsubishi,.*', '^miyoo,.*', '^mntre,.*',
>> '^modtronix,.*', '^mosaixtech,.*', '^motorola,.*', '^moxa,.*',
>> '^mpl,.*', '^mps,.*', '^mqmaker,.*', '^mrvl,.*', '^mscc,.*',
>> '^msi,.*', '^mstar,.*', '^mti,.*', '^multi-inno,.*',
>> '^mundoreader,.*', '^murata,.*', '^mxic,.*', '^mxicy,.*', '^myir,.*',
>> '^national,.*', '^nec,.*', '^neonode,.*', '^netgear,.*',
>> '^netlogic,.*', '^netron-dy,.*', '^netronix,.*', '^netxeon,.*',
>> '^neweast,.*', '^newhaven,.*', '^nexbox,.*', '^nextthing,.*',
>> '^ni,.*', '^nintendo,.*', '^nlt,.*', '^nokia,.*', '^nordic,.*',
>> '^novtech,.*', '^nutsboard,.*', '^nuvoton,.*', '^nvd,.*',
>> '^nvidia,.*', '^nxp,.*', '^oceanic,.*', '^ocs,.*', '^oct,.*',
>> '^okaya,.*', '^oki,.*', '^olimex,.*', '^olpc,.*', '^oneplus,.*',
>> '^onion,.*', '^onnn,.*', '^ontat,.*', '^opalkelly,.*',
>> '^opencores,.*', '^openembed,.*', '^openrisc,.*', '^option,.*',
>> '^oranth,.*', '^orisetech,.*', '^ortustech,.*', '^osddisplays,.*',
>> '^osmc,.*', '^ouya,.*', '^overkiz,.*', '^ovti,.*', '^oxsemi,.*',
>> '^ozzmaker,.*', '^panasonic,.*', '^parade,.*', '^parallax,.*',
>> '^pda,.*', '^pericom,.*', '^pervasive,.*', '^phicomm,.*',
>> '^phytec,.*', '^picochip,.*', '^pine64,.*', '^pineriver,.*',
>> '^pixcir,.*', '^plantower,.*', '^plathome,.*', '^plda,.*', '^plx,.*',
>> '^ply,.*', '^pni,.*', '^pocketbook,.*', '^polaroid,.*',
>> '^portwell,.*', '^poslab,.*', '^pov,.*', '^powertip,.*',
>> '^powervr,.*', '^primux,.*', '^probox2,.*', '^prt,.*',
>> '^pulsedlight,.*', '^purism,.*', '^qca,.*', '^qcom,.*', '^qemu,.*',
>> '^qi,.*', '^qiaodian,.*', '^qihua,.*', '^qishenglong,.*', '^qnap,.*',
>> '^radxa,.*', '^raidsonic,.*', '^ralink,.*', '^ramtron,.*',
>> '^raspberrypi,.*', '^raydium,.*', '^rda,.*', '^realtek,.*',
>> '^remarkable,.*', '^renesas,.*', '^rervision,.*', '^revotics,.*',
>> '^rex,.*', '^richtek,.*', '^ricoh,.*', '^rikomagic,.*', '^riot,.*',
>> '^riscv,.*', '^rockchip,.*', '^rocktech,.*', '^rohm,.*', '^ronbo,.*',
>> '^roofull,.*', '^roseapplepi,.*', '^samsung,.*', '^samtec,.*',
>> '^sancloud,.*', '^sandisk,.*', '^satoz,.*', '^sbs,.*',
>> '^schindler,.*', '^seagate,.*', '^seeed,.*', '^seirobotics,.*',
>> '^semtech,.*', '^senseair,.*', '^sensirion,.*', '^sensortek,.*',
>> '^sff,.*', '^sgd,.*', '^sgmicro,.*', '^sgx,.*', '^sharp,.*',
>> '^shimafuji,.*', '^shiratech,.*', '^si-en,.*', '^si-linux,.*',
>> '^siemens,.*', '^sifive,.*', '^sigma,.*', '^sii,.*', '^sil,.*',
>> '^silabs,.*', '^silan,.*', '^silead,.*', '^silergy,.*',
>> '^silex-insight,.*', '^siliconfile,.*', '^siliconmitus,.*',
>> '^silvaco,.*', '^simtek,.*', '^sinlinx,.*', '^sinovoip,.*',
>> '^sinowealth,.*', '^sipeed,.*', '^sirf,.*', '^sis,.*', '^sitronix,.*',
>> '^skov,.*', '^skyworks,.*', '^smartlabs,.*', '^smsc,.*', '^snps,.*',
>> '^sochip,.*', '^socionext,.*', '^solidrun,.*', '^solomon,.*',
>> '^sony,.*', '^spansion,.*', '^sparkfun,.*', '^spinalhdl,.*',
>> '^sprd,.*', '^ssi,.*', '^sst,.*', '^sstar,.*', '^st,.*',
>> '^st-ericsson,.*', '^starfive,.*', '^starry,.*', '^startek,.*',
>> '^ste,.*', '^stericsson,.*', '^storlink,.*', '^storm,.*',
>> '^storopack,.*', '^summit,.*', '^sunchip,.*', '^sunplus,.*',
>> '^supermicro,.*', '^swir,.*', '^syna,.*', '^synology,.*',
>> '^synopsys,.*', '^tbs,.*', '^tbs-biometrics,.*', '^tcg,.*', '^tcl,.*',
>> '^tcs,.*', '^tdo,.*', '^team-source-display,.*', '^technexion,.*',
>> '^technologic,.*', '^techstar,.*', '^teltonika,.*', '^tempo,.*',
>> '^terasic,.*', '^tesla,.*', '^tfc,.*', '^thead,.*', '^thine,.*',
>> '^thingyjp,.*', '^thundercomm,.*', '^ti,.*', '^tianma,.*', '^tlm,.*',
>> '^tmt,.*', '^topeet,.*', '^topic,.*', '^toppoly,.*', '^topwise,.*',
>> '^toradex,.*', '^toshiba,.*', '^toumaz,.*', '^tpk,.*', '^tplink,.*',
>> '^tpo,.*', '^tq,.*', '^traverse,.*', '^tronfy,.*', '^tronsmart,.*',
>> '^truly,.*', '^tsd,.*', '^tyan,.*', '^u-blox,.*', '^u-boot,.*',
>> '^ubnt,.*', '^ucrobotics,.*', '^udoo,.*', '^ugoos,.*', '^uniwest,.*',
>> '^upisemi,.*', '^urt,.*', '^usi,.*', '^utoo,.*', '^v3,.*',
>> '^vaisala,.*', '^vamrs,.*', '^variscite,.*', '^vdl,.*',
>> '^vertexcom,.*', '^via,.*', '^vicor,.*', '^videostrong,.*',
>> '^virtio,.*', '^virtual,.*', '^vishay,.*', '^visionox,.*',
>> '^vitesse,.*', '^vivante,.*', '^vivax,.*', '^vocore,.*', '^voipac,.*',
>> '^vot,.*', '^vxt,.*', '^wanchanglong,.*', '^wand,.*', '^waveshare,.*',
>> '^wd,.*', '^we,.*', '^welltech,.*', '^wetek,.*', '^wexler,.*',
>> '^whwave,.*', '^wi2wi,.*', '^wiligear,.*', '^willsemi,.*',
>> '^winbond,.*', '^wingtech,.*', '^winlink,.*', '^winstar,.*',
>> '^wirelesstag,.*', '^wits,.*', '^wlf,.*', '^wm,.*', '^wobo,.*',
>> '^x-powers,.*', '^xen,.*', '^xes,.*', '^xiaomi,.*', '^xillybus,.*',
>> '^xingbangda,.*', '^xinpeng,.*', '^xiphera,.*', '^xlnx,.*',
>> '^xnano,.*', '^xunlong,.*', '^xylon,.*', '^yadro,.*', '^yamaha,.*',
>> '^yes-optoelectronics,.*', '^yic,.*', '^ylm,.*', '^yna,.*',
>> '^yones-toptech,.*', '^ys,.*', '^ysoft,.*', '^zarlink,.*',
>> '^zealz,.*', '^zeitec,.*', '^zidoo,.*', '^zii,.*', '^zinitix,.*',
>> '^zkmagic,.*', '^zte,.*', '^zyxel,.*'
>>   From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>
>> Rob
>
> Thanks,
> Miquèl

-- 
Best regards,
Mikhail

