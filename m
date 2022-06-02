Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D008153B174
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 04:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiFBCH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 22:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiFBCHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 22:07:25 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0501D92DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 19:07:24 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r71so3545867pgr.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 19:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=9NElvwDqQjtltn5l/jL3hoAw2ukv8yqwztD6Fj5di1M=;
        b=ts73Ty4+pWhTgyjAU4ZSp9qhVwJ7e7RAJ0vNvocMNUPqEU1M7sRJdl5stT4dLBwesy
         eVj6pHpvALHme5uNN14rjG4DX9mroKj9lkFjrXckBPYEsnAN1wFIM9oIUkhVsrzbNQle
         6rVkFZw7qsDla1y1knfjFr7MH+4Mc7m2ISTDaPMFl1cS+jhjzl1yZ6k/M3Dey0y6742t
         EKaa7KJuTsu2xz3pv8tGlws1cYCff/+4qTnXp3/nLWYBEYCO9XHLJCckuGyZ0yb9yxDZ
         eLBN56kRta4qZ8zzXfd9C3YMDhb0DaGOnwvvIppJ4Z1HSPvR1Y1s3B31Oc2BToZfrExA
         iTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=9NElvwDqQjtltn5l/jL3hoAw2ukv8yqwztD6Fj5di1M=;
        b=qu9cqru8mb6kEIj4kg2U7nAw8cGk3S3rRUgy2OnWJ6V+BzzGj8ObezSDPKCM5Cc2yf
         JGZmKP07N82Na34pLK+nlAgE1unw5H+W5t8hBVFtj8Xuoefm3L8wbL5M7rJhCCLLIGWk
         fhaTM2Z4nc/mhz4Kfo2/TrxetLO+jTJAtsBJqtkraugvVXL6t/Swya/bFAoTH8M//T/K
         rrF/Xrs+oAireejoj7jHoFVRSHavZAsk9jFoffSo60dp5QmRL5ftcHz0CoQRsNxd48DE
         Rn+7tb4jswBE5oJx9QATb07FO4YV7D23PmuOS7tROM15yvYGAAZ12FzAFJ9WaMlXAdjg
         qaIw==
X-Gm-Message-State: AOAM531RkOB72K+TXEqnreTnPvuAbaBFJB+3xCResw96TFamqnezZMqF
        Kuw36LuIQjt+jrOPH+iW8EusNQ==
X-Google-Smtp-Source: ABdhPJw8GekBVL89dMuO5NhjVjGxu96NDqLPBmLWMhMxDu5JU8tAny589qxOrma5vzcXx5Q+ly3sZA==
X-Received: by 2002:a05:6a00:228c:b0:518:9533:4a1e with SMTP id f12-20020a056a00228c00b0051895334a1emr2528169pfe.79.1654135643698;
        Wed, 01 Jun 2022 19:07:23 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709026f0800b0016632179ecfsm1437844plk.264.2022.06.01.19.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 19:07:23 -0700 (PDT)
Date:   Wed, 01 Jun 2022 19:07:23 -0700 (PDT)
X-Google-Original-Date: Wed, 01 Jun 2022 19:07:17 PDT (-0700)
Subject:     Re: [PATCH v5 00/10] PolarFire SoC dt for 5.19
In-Reply-To: <3cf58174-1ddd-219f-9f14-4d0015f697e7@microchip.com>
CC:     robh+dt@kernel.org, krzk+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Daire.McNamara@microchip.com,
        Cyril.Jean@microchip.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de, Arnd Bergmann <arnd@arndb.de>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor.Dooley@microchip.com
Message-ID: <mhng-2bb14a91-66b8-4e35-b58e-4b29bf2c5558@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 04:47:55 PDT (-0700), Conor.Dooley@microchip.com wrote:
> On 09/05/2022 15:26, Conor Dooley wrote:
>> Hey all,
>> Got a few PolarFire SoC device tree related changes here for 5.19.
> 
> Hey Palmer,
> I know you're busy etc but I had been hoping you'd take this for
> 5.19. I know it's late, so nw if it's too late.

It wasn't too late for me, this is on for-next.  Thanks!

> Thanks,
> Conor.
> 
>> 
>> Firstly, patches 1 & 2 of this series supersede [0] & are unchanged
>> compared to that submission, figured it would just be easier to keep
>> all the changes in one series.
>> 
>> As discussed on irc, patch 3 removes the duplicated "microchip" from
>> the device tree files so that they follow a soc-board.dts & a
>> soc{,-fabric}.dtsi format.
>> 
>> Patch 5 makes the fabric dtsi board specific by renaming the file to
>> mpfs-icicle-kit-fabric.dtsi & including it in the dts rather than
>> mpfs.dtsi. Additionally this will allow other boards to define their
>> own reference fabric design. A revision specific compatible, added in
>> patch 4, is added to the dt also.
>> 
>> The remainder of the series adds a bare minimum devicetree for the
>> Sundance Polarberry.
>> 
>> Thanks,
>> Conor.
>> 
>> Changes since v4:
>> - Whitespace and status ordering changes in the polarberry dt pointed
>>    out by Heiko
>> - A new patch for same whitspace and status order changes, but applied
>>    to the icicle dt
>> - A reordering of the icicle dt alphabetically to match the formatting
>>    of the polarberry dt
>> 
>> Changes since v3:
>> - remove an extra line of wshitespace added to dt-binding
>> - remove unneeded "okay" status & sort status to node end
>> - sort polarberry dts entries in ~alphabetical order
>> - add a comment explaining why the second mac (mac0) is disabled on
>>    polarberry
>> 
>> Changes since v2:
>> - make ,icicle-reference compatible with ,mpfs & put it inside the enum
>> 
>> Changes since v1:
>> - fixed whitespace problems in the polarberry dts
>> - disabled mac0 for the polarberry as its port is on the optional
>>    carrier board
>> 
>> Conor Dooley (10):
>>    riscv: dts: microchip: remove icicle memory clocks
>>    riscv: dts: microchip: move sysctrlr out of soc bus
>>    riscv: dts: microchip: remove soc vendor from filenames
>>    dt-bindings: riscv: microchip: document icicle reference design
>>    riscv: dts: microchip: make the fabric dtsi board specific
>>    dt-bindings: vendor-prefixes: add Sundance DSP
>>    dt-bindings: riscv: microchip: add polarberry compatible string
>>    riscv: dts: microchip: add the sundance polarberry
>>    riscv: microchip: icicle: readability fixes
>>    riscv: dts: icicle: sort nodes alphabetically
>> 
>>   .../devicetree/bindings/riscv/microchip.yaml  |   2 +
>>   .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>>   arch/riscv/boot/dts/microchip/Makefile        |   3 +-
>>   ...abric.dtsi => mpfs-icicle-kit-fabric.dtsi} |   2 +
>>   ...pfs-icicle-kit.dts => mpfs-icicle-kit.dts} | 105 +++++++++---------
>>   .../dts/microchip/mpfs-polarberry-fabric.dtsi |  16 +++
>>   .../boot/dts/microchip/mpfs-polarberry.dts    |  99 +++++++++++++++++
>>   .../{microchip-mpfs.dtsi => mpfs.dtsi}        |  11 +-
>>   8 files changed, 181 insertions(+), 59 deletions(-)
>>   rename arch/riscv/boot/dts/microchip/{microchip-mpfs-fabric.dtsi => mpfs-icicle-kit-fabric.dtsi} (91%)
>>   rename arch/riscv/boot/dts/microchip/{microchip-mpfs-icicle-kit.dts => mpfs-icicle-kit.dts} (95%)
>>   create mode 100644 arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
>>   create mode 100644 arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
>>   rename arch/riscv/boot/dts/microchip/{microchip-mpfs.dtsi => mpfs.dtsi} (98%)
>> 
> 
