Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824094737A2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbhLMWf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbhLMWf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:35:56 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A70C061748
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:35:56 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id i13so5456468ilk.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DBnoK0OyUlLAOuBvNnnmeaqng0RVQtz+D/6i7hX6jWw=;
        b=Bhm14wsvKoSI0/zY2t5qbEGLX3rimfq0X7e4D6CRc/EBSTiB9tyTe1TdneBiH5ffsk
         UaeScdmpN34MTic0smNzK4HLAIrGz4HI1eUbvWWeSWJJf5YBvXR8/Izobn+xDc23SYhN
         u9/bNysjKr+Xj/qpL/UTFhyJZLm2uKT4zI95Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DBnoK0OyUlLAOuBvNnnmeaqng0RVQtz+D/6i7hX6jWw=;
        b=rwM/VxHg6jdPfAQzEJNfDDVbwj7cilUE01zq7gBMnR1j/oCtIt+EkXP0aZIko7Cymh
         OWVmQ193T+iXekol+PztsentA3UUFJTEkdZzPkSYubDygKdQHTKAQ/wjyTy5D6STE+Bp
         5Vb4Agutcgh4v3x5eHGKvuWee7vUCoyT+CKycjWKOdDTu3aP8m0AkCeJmiQq0WoCeaE4
         e2C1SH7ShVlHO+RBwDRoaAqhaXwucpQtNYoDTIpObZHZfB+lXvW0snLn/++tL9NGWw9i
         1u64ZBxVEZdHn/6U2vaJt2y7q4OQy8eZIrVSLRS5VeCxmELCdlBJQANrjLAwAy6jLXBs
         aw4w==
X-Gm-Message-State: AOAM532HU8IdkY4vXfKe9/EL8EBlqUolBolP5QXXqD6sJ6DCLFqGX627
        YByprL70acUcASPV7kmLf7QiKQ==
X-Google-Smtp-Source: ABdhPJyiXtBZAbBl/VCDVBUa2jlIRWHm5zgggZp0SD5B9ipv2ZOn3XqoayIO2zQUgkFfP9euHt3vmQ==
X-Received: by 2002:a05:6e02:1c85:: with SMTP id w5mr978973ill.272.1639434955349;
        Mon, 13 Dec 2021 14:35:55 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id f10sm7681208iob.7.2021.12.13.14.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 14:35:54 -0800 (PST)
Message-ID: <f283eb6c-fa39-c4bc-5da8-747ce20317da@ieee.org>
Date:   Mon, 13 Dec 2021 16:35:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH V6 0/7] Add driver support for Data Capture and Compare
 Engine(DCC) for SM8150,SC7280,SC7180,SDM845
Content-Language: en-US
To:     Souradeep Chowdhury <schowdhu@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, vkoul@kernel.org
References: <cover.1628617260.git.schowdhu@codeaurora.org>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <cover.1628617260.git.schowdhu@codeaurora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 12:54 PM, Souradeep Chowdhury wrote:
> DCC(Data Capture and Compare) is a DMA engine designed for debugging purposes.In case of a system
> crash or manual software triggers by the user the DCC hardware stores the value at the register
> addresses which can be used for debugging purposes.The DCC driver provides the user with sysfs
> interface to configure the register addresses.The options that the DCC hardware provides include
> reading from registers,writing to registers,first reading and then writing to registers and looping
> through the values of the same register.

I realize this was posted a long time ago but I spent a little
time on it today, and I have some comments for you to consider.
You'll need to post another version of this series if you're
going to address some of my comments.

Most of the comments are in patch 2, which contains all the code
and the sysfs documentation.  I have no comments on patches 3
(MAINTAINERS update) or 4 through 7 (DTS updates for specific
platforms).

First, a few comments on this cover page.  The most trivial
comment is:  Please make your lines narrower than 80 columns,
like the rest of the patches.

I appreciate that this goes into some detail about how this
feature has been used.  But I think it could benefit from
a little better high-level overview of what it *does*.
Your first paragraph is a concise summary, but I find it
doesn't evoke a model in my mind of what exactly is going
on, or what the hardware is doing.  In fact, if you can
provide a good high-level overview it might belong at the
top of "dcc.c" in comments.

Looking at the code (but not in any great depth), I see
that there are "linked lists" of what appear to be things
for the hardware to do with memory when this hardware is
"triggered."  If I understand it right, there can be up
to 8 of these lists (though some versions of hardware
might advertise the number supported via a register).

If the following is wrong, I hope you'll offer a comparable
explanation and will correct my misunderstanding.

Each list consists of a set of actions to take.  The actions
available include: reading a register (possibly <count> times
in succession); writing a register; and read/modify/writing
a register (affecting only bits in a given mask).  Actually,
the way looping works is a little confusing to me.

Each list can be enabled and disabled separately.  When
triggered, all lists are executed, and (somehow) the result
is saved into a buffer that can be read via /dev/dcc_sram.

So you use these sysfs files to configure the actions you'd
like to take when a "trigger" is signaled.  The content of
/dev/dcc_sram can then be read to see what output your
lists produced.

Is that close to correct?  If it is, great; I want to be
sure I understand what the hardware is supposed to do
before I comment much more on the way you represent it
in the driver and in sysfs.

> In certain cases a register write needs to be executed for accessing the rest of the registers,
> also the user might want to record the changing values of a register with time for which he has the
> option to use the loop feature.
> 
> The options mentioned above are exposed to the user by sysfs files once the driver is probed.The
> details and usage of this sysfs files are documented in Documentation/ABI/testing/sysfs-driver-dcc.

Once you've confirmed I understand what's supposed to happen
when the trigger fires, I think I'll have some comments on
the way you represent the actions in these lists.  But
for now, maybe keep things as you have them, but address
some of the comments I'm giving you today.  Copy me on
future revisions and I'll plan to review again.

OK, that's enough on this file for now.  Onto the binding and
the code...

					-Alex

> As an example let us consider a couple of debug scenarios where DCC has been proved to be effective
> for debugging purposes:-
> 
> i)TimeStamp Related Issue
> 
> On SC7180, there was a coresight timestamp issue where it would occasionally be all 0 instead of proper
> timestamp values.
> 
> Proper timestamp:
> Idx:3373; ID:10; I_TIMESTAMP : Timestamp.; Updated val = 0x13004d8f5b7aa; CC=0x9e
> 
> Zero timestamp:
> Idx:3387; ID:10; I_TIMESTAMP : Timestamp.; Updated val = 0x0; CC=0xa2
> 
> Now this is a non-fatal issue and doesn't need a system reset, but still needs
> to be rootcaused and fixed for those who do care about coresight etm traces.
> Since this is a timestamp issue, we would be looking for any timestamp related
> clocks and such.
> 
> o we get all the clk register details from IP documentation and configure it
> via DCC config syfs node. Before that we set the current linked list.
> 
> /* Set the current linked list */
> echo 3 > /sys/bus/platform/devices/10a2000.dcc/curr_list
> 
> /* Program the linked list with the addresses */
> echo 0x10c004 > /sys/bus/platform/devices/10a2000.dcc/config
> echo 0x10c008 > /sys/bus/platform/devices/10a2000.dcc/config
> echo 0x10c00c > /sys/bus/platform/devices/10a2000.dcc/config
> echo 0x10c010 > /sys/bus/platform/devices/10a2000.dcc/config
> ..... and so on for other timestamp related clk registers
> 
> /* Other way of specifying is in "addr len" pair, in below case it
> specifies to capture 4 words starting 0x10C004 */
> 
> echo 0x10C004 4 > /sys/bus/platform/devices/10a2000.dcc/config
> 
> /* Enable DCC */
> echo 1 > /sys/bus/platform/devices/10a2000.dcc/enable
> 
> /* Run the timestamp test for working case */
> 
> /* Send SW trigger */
> echo 1 > /sys/bus/platform/devices/10a2000.dcc/trigger
> 
> /* Read SRAM */
> cat /dev/dcc_sram > dcc_sram1.bin
> 
> /* Run the timestamp test for non-working case */
> 
> /* Send SW trigger */
> echo 1 > /sys/bus/platform/devices/10a2000.dcc/trigger
> 
> /* Read SRAM */
> cat /dev/dcc_sram > dcc_sram2.bin
> 
> Get the parser from [1] and checkout the latest branch.
> 
> /* Parse the SRAM bin */
> python dcc_parser.py -s dcc_sram1.bin --v2 -o output/
> python dcc_parser.py -s dcc_sram2.bin --v2 -o output/
> 
> Sample parsed output of dcc_sram1.bin:
> 
> <hwioDump version="1">
>          <timestamp>03/14/21</timestamp>
>              <generator>Linux DCC Parser</generator>
>                  <chip name="None" version="None">
>                  <register address="0x0010c004" value="0x80000000" />
>                  <register address="0x0010c008" value="0x00000008" />
>                  <register address="0x0010c00c" value="0x80004220" />
>                  <register address="0x0010c010" value="0x80000000" />
>              </chip>
>      <next_ll_offset>next_ll_offset : 0x1c </next_ll_offset>
> </hwioDump>
> 
> ii)NOC register errors
> 
> A particular class of registers called NOC which are functional registers was reporting
> errors while logging the values.To trace these errors the DCC has been used effectively.
> The steps followed were similar to the ones mentioned above.
> In addition to NOC registers a few other dependent registers were configured in DCC to
> monitor it's values during a crash. A look at the dependent register values revealed that
> the crash was happening due to a secured access to one of these dependent registers.
> All these debugging activity and finding the root cause was achieved using DCC.
> 
> DCC parser is available at the following open source location
> 
> https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/tools/tree/dcc_parser
> 
> Changes in v6:
> 
> *Added support in the dcc driver to handle multiple Qualcomm SoCs including SC7180,SC7280,SDM845
>   along with existing SM8150.
>   
> *Added the support node in the respective device tree files for SC7180,SC7280,SDM845.
> 
> Souradeep Chowdhury (7):
>    dt-bindings: Added the yaml bindings for DCC
>    soc: qcom: dcc:Add driver support for Data Capture and Compare
>      unit(DCC)
>    MAINTAINERS: Add the entry for DCC(Data Capture and Compare) driver
>      support
>    arm64: dts: qcom: sm8150: Add Data Capture and Compare(DCC) support
>      node
>    arm64: dts: qcom: sc7280: Add Data Capture and Compare(DCC) support
>      node
>    arm64: dts: qcom: sc7180: Add Data Capture and Compare(DCC) support
>      node
>    arm64: dts: qcom: sdm845: Add Data Capture and Compare(DCC) support
>      node
> 
>   Documentation/ABI/testing/sysfs-driver-dcc         |  114 ++
>   .../devicetree/bindings/arm/msm/qcom,dcc.yaml      |   43 +
>   MAINTAINERS                                        |    8 +
>   arch/arm64/boot/dts/qcom/sc7180.dtsi               |    6 +
>   arch/arm64/boot/dts/qcom/sc7280.dtsi               |    6 +
>   arch/arm64/boot/dts/qcom/sdm845.dtsi               |    6 +
>   arch/arm64/boot/dts/qcom/sm8150.dtsi               |    6 +
>   drivers/soc/qcom/Kconfig                           |    8 +
>   drivers/soc/qcom/Makefile                          |    1 +
>   drivers/soc/qcom/dcc.c                             | 1549 ++++++++++++++++++++
>   10 files changed, 1747 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-driver-dcc
>   create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
>   create mode 100644 drivers/soc/qcom/dcc.c
> 

