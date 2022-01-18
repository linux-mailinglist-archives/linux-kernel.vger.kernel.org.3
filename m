Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8519492049
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245397AbiARH1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:27:39 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:56144 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245157AbiARH0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:26:53 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220118072648epoutp03884f0f0ab06c47d986ef23821355f563~LTLAYokpv2005820058epoutp03F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 07:26:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220118072648epoutp03884f0f0ab06c47d986ef23821355f563~LTLAYokpv2005820058epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642490808;
        bh=Zg0RU9t5W1nXKXsU2UNw4q6sL2viMGbVEqOgjrgpgsY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=CNcB8ZoMoTnViy3OSGV6mMlqNTWjxffp9cQHpMPYzPKgebMx4MGbrnVEpZe68WaBN
         M3u4hpsVOS5/8BBcKABoec0RwBXdjvJEwRdFims87SDPeCA7wcg3MGhdBZtYxjX7bA
         3ThQrAm736d36D4TWi8dyJmSmqVMWX7dF4YIIiX0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220118072647epcas5p1419e8d3f15254d71568b1e88edca0923~LTK-3cT3s0182301823epcas5p17;
        Tue, 18 Jan 2022 07:26:47 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JdL1T2mZ1z4x9Q5; Tue, 18 Jan
        2022 07:26:37 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.F2.06423.AAB66E16; Tue, 18 Jan 2022 16:26:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220118072633epcas5p484d86503f12b803cfb83cd20954b3626~LTKyyh9UU2404324043epcas5p4Y;
        Tue, 18 Jan 2022 07:26:33 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220118072633epsmtrp19d54e1f50077be4c8e6b0ee62780545a~LTKyxqVGq1052610526epsmtrp17;
        Tue, 18 Jan 2022 07:26:33 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-0f-61e66baa8d47
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.BD.08738.9AB66E16; Tue, 18 Jan 2022 16:26:33 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220118072631epsmtip213571a9cbf9be5f39b0a6df5f2326652~LTKwsg1SV0825508255epsmtip2f;
        Tue, 18 Jan 2022 07:26:31 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Henrik Grimler'" <henrik@grimler.se>
Cc:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <semen.protsenko@linaro.org>, <virag.david003@gmail.com>,
        <martin.juecker@gmail.com>, <cw00.choi@samsung.com>,
        <m.szyprowski@samsung.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
In-Reply-To: <YeWgNJaDHxKROpQs@grimlerstat>
Subject: RE: [PATCH v3 3/3] ARM: dts: Add support for Samsung Chagall WiFi
Date:   Tue, 18 Jan 2022 12:56:30 +0530
Message-ID: <01c501d80c3c$b820fb90$2862f2b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKTrlzLhJbN5e22s0Ks3rGJhMIi0gCNReXFAo1zs98Cp4BzmQGZbeD4AaJ5xbYBhx1hmaqc71SA
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRmVeSWpSXmKPExsWy7bCmlu6q7GeJBhtP8Fhc//Kc1WL+kXOs
        Fm+X7GK02Pj2B5PFpsfXWC0u75rDZjHj/D4mi7VH7rJbnPk3lcWide8RdovnfUCx4+8fM1ps
        /v6X0YHXY1ZDL5vHzll32T2OXrnH6rFpVSebx51re9g8Ni+p9/h/Zy27R9+WVYwenzfJBXBG
        ZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAN2tpFCW
        mFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjO
        +Pqlh7Xgp0nF2vY+1gbGqZpdjJwcEgImEk877zJ3MXJxCAnsZpS4uewLO4TziVHi+NbJrBDO
        Z0aJV/fOs8C03P5ylQUisYtR4sv2/1DOS0aJJd1NjCBVbAK6EjsWt7GB2CICWhJTN3wAW8Is
        sIBZ4k3HfLAEp4C2xJVVp5lBbGEBL4mfd3+zgtgsAqoSK05uAFvHK2Ap0d1wjhnCFpQ4OfMJ
        WJxZQF5i+9s5zBAnKUj8fLqMFWJZlETrx5WsEDXiEi+PHgF7SELgAYfE28b9TBANLhL9l46y
        QtjCEq+Ob2GHsKUkXva3AdkcQHa2RM8uY4hwjcTSeceg3reXOHBlDgtICbOApsT6XfoQq/gk
        en8/YYLo5JXoaBOCqFaVaH53FapTWmJidzfUUg+Jly07WSYwKs5C8tgsJI/NQvLALIRlCxhZ
        VjFKphYU56anFpsWGOallsMjPDk/dxMjOFlree5gvPvgg94hRiYOxkOMEhzMSiK8x7ifJArx
        piRWVqUW5ccXleakFh9iNAWG9kRmKdHkfGC+yCuJNzSxNDAxMzMzsTQ2M1QS5z2dviFRSCA9
        sSQ1OzW1ILUIpo+Jg1OqgcmL/05zL59rs1DZ+dbemmXiO4+HRvZfWmWjOoH5kVwYo+5dycMn
        Hb83bFZay7DeJ71U6HTfXLujic9/zr/GxDbj2dxLnUrno56svTThNKts1oTXLX7pm3Oub2U8
        9OrLVxujI+dXlij/8D8rJMrqIZ4x0d0yu/9wfxZHxmLtI43flU69+XHM7ebqmPnWanl9bxkz
        rr9+LMRrFXL42KTdbw1+Zs54HGuaOnWlzYyrF4OXFDWznS9jzrt1qcl5H19E0Z2ru/JnLlld
        aWgyvVClM7U08fy20ryftbIpBjyJ12UnqLz4cEosvlekWfhLuFRJ8N6bJWpzHd48X3Sk0IY5
        7HOYYPchb76DizKiFf1usCqxFGckGmoxFxUnAgCw6mfJXwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWy7bCSvO7K7GeJBgsPqllc//Kc1WL+kXOs
        Fm+X7GK02Pj2B5PFpsfXWC0u75rDZjHj/D4mi7VH7rJbnPk3lcWide8RdovnfUCx4+8fM1ps
        /v6X0YHXY1ZDL5vHzll32T2OXrnH6rFpVSebx51re9g8Ni+p9/h/Zy27R9+WVYwenzfJBXBG
        cdmkpOZklqUW6dslcGV8/dLDWvDTpGJtex9rA+NUzS5GTg4JAROJ21+usnQxcnEICexglGjc
        co0NIiEtcX3jBHYIW1hi5b/n7BBFzxklLrTvZwZJsAnoSuxY3AbWICKgJTF1wwdmkCJmgVXM
        EmtvTYLquMQkcWbhO1aQKk4BbYkrq06DdQsLeEn8vPsbLM4ioCqx4uQGFhCbV8BSorvhHDOE
        LShxcuYToDgH0FQ9ibaNjCBhZgF5ie1v5zBDXKcg8fPpMlaII6IkWj+uZIWoEZd4efQI+wRG
        4VlIJs1CmDQLyaRZSDoWMLKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjlgtrR2M
        e1Z90DvEyMTBeIhRgoNZSYT3GPeTRCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeW
        pGanphakFsFkmTg4pRqYrO+tP1qb6rnVKIvPJlrx9XdJhRvTp5gyzxe/Okdw62atL3tyX91k
        OVG3/pvGum1hRlcbxP/+bGNW//ruV96796uPFzwzVt4yWbXz2et9xWYndlcs33pj5Q3zgBDu
        9VfCvNfq1uvoZAj5LLr1rWlS1I/8YN0n4bNeGvlnFuwyu7bmj8OygjUR56ulk/Q6zA56skhv
        qFpzQEws9Z6m2MJTf/fNdOTp/dNwtu/Ur7PsfHVN1SGHHKakx+eq58bO+vmjWf+kx2q17NMv
        3F/v137ufDnJ9NDLsqfPI24kzHktEbLBYN+KFz/9lonPyhSw2hldvu2gy8437S12T8+EiTG3
        vm1/96ZiaR1r3dO19iZNS5RYijMSDbWYi4oTASmEpy9HAwAA
X-CMS-MailID: 20220118072633epcas5p484d86503f12b803cfb83cd20954b3626
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220116205940epcas5p3dbab01fb6bb7a4af76169231e6d94469
References: <20220116165035.437274-1-henrik@grimler.se>
        <20220116165035.437274-4-henrik@grimler.se>
        <ca8c4613-a058-6cde-f9e6-8530f142a821@canonical.com>
        <CGME20220116205940epcas5p3dbab01fb6bb7a4af76169231e6d94469@epcas5p3.samsung.com>
        <YeSHNCywXhp8gHC7@L14.lan> <001301d80b66$190901a0$4b1b04e0$@samsung.com>
        <YeWgNJaDHxKROpQs@grimlerstat>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henrik

>-----Original Message-----
>From: Henrik Grimler [mailto:henrik@grimler.se]
>Sent: Monday, January 17, 2022 10:28 PM
>To: Alim Akhtar <alim.akhtar@samsung.com>
>Cc: 'Krzysztof Kozlowski' <krzysztof.kozlowski@canonical.com>;
>semen.protsenko@linaro.org; virag.david003@gmail.com;
>martin.juecker@gmail.com; cw00.choi@samsung.com;
>m.szyprowski@samsung.com; robh+dt@kernel.org;
>devicetree@vger.kernel.org; linux-samsung-soc@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>~postmarketos/upstreaming@lists.sr.ht
>Subject: Re: [PATCH v3 3/3] ARM: dts: Add support for Samsung Chagall WiFi
>
>Hi Alim,
>
>> >> > +/* External sdcard */
>> >> > +&mmc_2 {
>> >> > +	status = "okay";
>> >> > +	bus-width = <4>;
>> >> > +	cap-sd-highspeed;
>> >> > +	card-detect-delay = <200>;
>> >> > +	pinctrl-0 = <&sd2_clk &sd2_cmd &mmc2_cd &sd2_bus1
>&sd2_bus4>;
>> >> > +	pinctrl-names = "default";
>> >> > +	samsung,dw-mshc-ciu-div = <3>;
>> >> > +	samsung,dw-mshc-ddr-timing = <0 2>;
>> >> > +	samsung,dw-mshc-sdr-timing = <0 4>;
>> >> > +	sd-uhs-sdr50;
>> >> > +	vmmc-supply = <&ldo19_reg>;
>> >> > +	vqmmc-supply = <&ldo13_reg>;
>> >> > +};
>> >> > +
>> >> > +&pinctrl_0 {
>> >> > +	mmc2_cd: sd2-cd-pins {
>> >> > +		samsung,pins = "gpx2-4";
>> >>
>> >> Interesting... I looked at vendor sources to board-chagall and
>> >> standard pin gpc2-2 is mentioned as PULL down and not-connected
>> >comment.
>> >>
>> >> gpx2-4 seems not mentioned at all, unless other board files are
>> >> actually used.
>> >
>> >Gpio seems to be spread out. GPIO_T_FLASH_DETECT is defined as gpx2-4
>> >in board-universal5420-mmc.c, and then used for card detection.
>> >(Looking at it now again I see that write protection through sd2_wp
>> >should also be supported for mmc_2, can add that in next patch set.)
>> >
>> Card detect pin is generally a special function (dedicated pin) pin,
>> directly connected from SoC to card external slot.
>> And for exynos5420 it is gpc2-2 as pointed by Krzysztof.
>
>gpio/pinctrl is still not my area of expertise so your feedback is greatly
>appreciated!
>
>gpc2-2 does not seem to be the card-detect pin for these tablets.  If I add
>sd2_cd to pinctrl-0 above I am unable to use the sdcard at all, instead
dmesg is
>filled with repeating messages like:
>
>[  18.669050] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req
>300000Hz, actual 297619HZ div = 84) [  18.703711] mmc_host mmc1: Bus speed
>(slot 0) = 50000000Hz (slot req 200000Hz, actual 200000HZ div = 125) [
>18.737167] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req
>100000Hz, actual 100000HZ div = 250) [  19.058352] mmc_host mmc1: Bus
>speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63) [
>19.093037] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req
>300000Hz, actual 297619HZ div = 84) [  19.127701] mmc_host mmc1: Bus speed
>(slot 0) = 50000000Hz (slot req 200000Hz, actual 200000HZ div = 125) [
>19.162380] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req
>100000Hz, actual 100000HZ div = 250)
>
>gpx2-4 on the other hand switches state when an sdcard is inserted or
>removed.  After exporting relevant pins I have, with the card
>inserted:
>
># grep -A 2 gpx2 /sys/kernel/debug/gpio
>gpiochip3: GPIOs 24-31, parent: platform/13400000.pinctrl, gpx2:
> gpio-26  (                    |Power               ) in  hi IRQ ACTIVE LOW
> gpio-28  (                    |sysfs               ) in  lo
>
>and when removed gpx2-4 changes to high:
>
>gpiochip3: GPIOs 24-31, parent: platform/13400000.pinctrl, gpx2:
> gpio-26  (                    |Power               ) in  hi IRQ ACTIVE LOW
> gpio-28  (                    |sysfs               ) in  hi
>
>All the gpc2 pins are low no matter if sdcard is inserted or removed:
>
>gpiochip7: GPIOs 56-62, parent: platform/13410000.pinctrl, gpc2:
> gpio-56  (                    |sysfs               ) in  lo
> gpio-57  (                    |sysfs               ) in  lo
> gpio-58  (                    |sysfs               ) in  lo
> gpio-59  (                    |sysfs               ) in  lo
> gpio-60  (                    |sysfs               ) in  lo
> gpio-61  (                    |sysfs               ) in  lo
> gpio-62  (                    |sysfs               ) in  lo
>
>That being said, I am not sure if it is working properly:
>
>> Also PIN_FUNC_2 for gpx2-4 indicate that it is wakeup_int2 function.
>> Do you get a card detect interrupt when removing and inserting the
>> card to the card slot?
> 
This is the confirmation that this board does not uses gpc2-2 but gpx2-4. 
Thanks for detailed log.

>(What is the best way to check this?) I don't get any irq related messages
in

Probably if you are interested, you can enable few debug in dw-mmc driver to
check a message like "card is present" etc.

>dmesg, and I don't see any changes in /proc/interrupts if tracked with
>something like `watch -n1 "cat /proc/interrupts"` when card is removed or
>inserted, so seems likely that pin config is wrong.
>All I can find in vendor kernel for this device is that pull config is set
to
>S3C_GPIO_PULL_NONE [1].  For some of the sibling tablets the pin is
>configured as {S3C_GPIO_INPUT, GPIO_LV_N, S3C_GPIO_PULL_NONE} [2]
>though, which I think should correspond to having:
>
>mmc2_cd: mmc2-cd-pins {
>  samsung,pins = "gpx2-4";
>  samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
>  samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>  samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>; };
>
>Changing to that does not seem to change anything though, I don't get any
>interrupt, or any messages in dmesg, when inserting or removing the sdcard.
>
>> Also to avoid confusion, probably you can change the node name as
>"mmc2_cd:
>> mmc2-cd-pins"
>> (as sd2-cd-pins is gpc2-2 for this SoC)
>
>Thanks, will fix in a v4 (after discussions here are settled).
>
I am convinced that gpc2-2 is not used for card detect for this board.
So no other query on this patch.
Thanks

>[1] https://protect2.fireeye.com/v1/url?k=bba823ae-dad5cbe9-bba9a8e1-
>74fe485fff30-b4ccbbe9776f501d&q=1&e=9951c78c-16c8-449e-913b-
>d4d1f1f9bb6b&u=https%3A%2F%2Fgithub.com%2Fexynos5420%2Fandroid_k
>ernel_samsung_exynos5420%2Fblob%2Flineage-
>17.1%2Farch%2Farm%2Fmach-exynos%2Fboard-universal5420-
>mmc.c%23L388
>[2] https://protect2.fireeye.com/v1/url?k=97465c6e-f63bb429-9747d721-
>74fe485fff30-4111389a6d2b68b4&q=1&e=9951c78c-16c8-449e-913b-
>d4d1f1f9bb6b&u=https%3A%2F%2Fgithub.com%2Fexynos5420%2Fandroid_k
>ernel_samsung_exynos5420%2Fblob%2Flineage-
>17.1%2Farch%2Farm%2Fmach-exynos%2Fboard-n1-gpio.c%23L119
>
>Best regards,
>Henrik Grimler

