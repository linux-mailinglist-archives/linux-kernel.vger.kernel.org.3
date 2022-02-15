Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C944B75CD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243867AbiBOUB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:01:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbiBOUB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:01:57 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0136EB19
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:01:46 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id r8so2944312ioc.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OhcZyZ8dAinN4R0OyLq51mKwClIiGsO5OAeQdPZeNkM=;
        b=b/sCxFB8KSKQQLl2BVDv6uQFiAWtjmDoBGIcT8T/Vjg5fQyESh+0Pse9n9JE3Dc1OL
         0KorNpU09vXhYowLmuNgsiDk/d/IS4Tt4k4vYzvrcyarwkK+UlZZh/7AckciitcqTP7k
         /mjLIVoyXXviNbkFnJf/F48eD3WL6SeXh14t92t7LEDAgeO+ELwpm4XRcJn1gXHBagfm
         srhwwddAYA3UwO1IRxz+HYRKpX9vM653XE6mSUc6HBL5CLFQ5v1TQXVFafc+QkvS/ynC
         qf7f590WiF9mp7wjlhDHlcZQVws2cGtf6lqzifhECsBpkFvE7rJ/Rdk5A1AhDSheMHIa
         5hNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OhcZyZ8dAinN4R0OyLq51mKwClIiGsO5OAeQdPZeNkM=;
        b=ne9LvYS6m4uze3wxCcpihWcXvckXi3G2kUSa5TVcs+ut2BKzOf9JXtWnn0hSQTop55
         Rnzc651y3sxzTCPE3/EsOL/BXE8XCUBCYmmWHc2Sof/i6++5Z2nlfxof0odT09r0tJDQ
         79FpNJ5IE86Fa2Qn5BQF5WYl3c1hkHzLsO8gKaWpr/TkGAInRr0/P7RlwiXKZTCgQRxh
         DhudR/eh1rYlNOSpUZ2Ba839JxgpX+4zlbAMf8e4c6Wgkjo6QLZ2znGP0SjbVEdXp1vZ
         ugKlbAO9gQ3FvFtCI4YXqh4SxGITwShhpGCoCEqtDWuRKPAwMVYkHylv2q5psF5HxU4m
         z1AQ==
X-Gm-Message-State: AOAM530317gLsqar4inrDsgJ3TVF/uzY/IXgxoX/l1pZHPhcr9aXUWC9
        3uX7PyCgBwZ8qM5pu/VfxxzHrA==
X-Google-Smtp-Source: ABdhPJw8BzjqE8ukc3tOqykApohDjuyZYJ9eCf0/hlHEe0eoPT3aiWx0QyeiNJuBYjpbaLV2WU1vUg==
X-Received: by 2002:a05:6602:3159:: with SMTP id m25mr328762ioy.114.1644955305462;
        Tue, 15 Feb 2022 12:01:45 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id g21sm24291268iow.4.2022.02.15.12.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 12:01:44 -0800 (PST)
Message-ID: <db84a31c-d0b3-ad83-d1fc-c1f8e0cb3d8b@linaro.org>
Date:   Tue, 15 Feb 2022 14:01:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 00/25] Add initial support for MHI endpoint stack
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/22 12:20 PM, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series adds initial support for the Qualcomm specific Modem Host Interface
> (MHI) bus in endpoint devices like SDX55 modems. The MHI bus in endpoint devices
> communicates with the MHI bus in host machines like x86 over any physical bus
> like PCIe. The MHI host support is already in mainline [1] and been used by PCIe
> based modems and WLAN devices running vendor code (downstream).

Maybe "running (downstream) vendor code".



I have a few general comments, which I'll mention here.

- This description goes out of its way to say MHI *could* be used over
   almost any transport, and PCIe just happens to be one of them.  The
   reality is, you are only supporting it over PCIe, and as far as I
   know you have no plans to go beyond that.  Even if you did, I think
   it should be clearer that you are doing MHI support over PCIe, even
   though other options are possible (and could be incorporated in the
   future).
- The first two patches are bug fixes; I think you should send those
   out right away, without waiting for the entire series to get accepted.
     - But ideally, can we get a "Tested-by" tag on these first?
- The next several, maybe up to patch 7, are also sort of preparatory
   for the "real" code you're adding.  Maybe those could be sent out
   early/separately too, knowing that the end goal is to get the MHI
   endpoint support accepted.
- Given the endianness issues (which I pointed out last time, but
   which seem to be addressed), are you able to test this code using
   a host that has different endianness than the modem CPU (SDX55)?
     - Paul Davey seems to have the ability to test this.
- I have a few very minor suggestions in the wording below.
- You really need a picture to make it easier to see at a glance what
   the hardware model is.  Here's one I did at one point, but it also
   includes the IPA in it (which is the FUUUUTURE!!!).  The SDX55 AP
   controls the PCIe endpoint.

   ....................            ..................................
   : "Intel host"     :            :             "SDX55"            :
   :                  :            :      ------------              :
   :                  :            :      | SDX55 AP |              :
   :                  :            :      ------------              :
   :                  :      | |   :           |                    :
   : -------- (root complex) |P| (endpoint) -------       --------- :
   : | Host |----------------|C|------------| IPA |-------| Modem | :
   : --------         :      |I|   :        -------       --------- :
   :..................:      |e|   :................................:
                             | |

   Something this picture does not show is that the transfer,
   command and event rings (and buffers) reside in host memory,
   while information *about* those rings (size, location, and
   current read/write pointers) reside in PCIe memory.

> Overview
> ========
> 
> This series aims at adding the MHI support in the endpoint devices with the goal

This series adds the MHI support...

> of getting data connectivity using the mainline kernel running on the modems.
> Modems here refer to the combination of an APPS processor (Cortex A grade) and
> a baseband processor (DSP). The MHI bus is located in the APPS processor and it
> transfers data packets from the baseband processor to the host machine.
> 
> The MHI Endpoint (MHI EP) stack proposed here is inspired by the downstream
> code written by Qualcomm. But the complete stack is mostly re-written to adapt
> to the "bus" framework and made it modular so that it can work with the upstream

...framework to make it modular, so that...

> subsystems like "PCI Endpoint". The code structure of the MHI endpoint stack
> follows the MHI host stack to maintain uniformity.
> 
> With this initial MHI EP stack (along with few other drivers), we can establish
> the network interface between host and endpoint over the MHI software channels
> (IP_SW0) and can do things like IP forwarding, SSH, etc...
> 
> Stack Organization
> ==================
> 
> The MHI EP stack has the concept of controller and device drivers as like the
> MHI host stack. The MHI EP controller driver can be a PCI Endpoint Function
> driver and the MHI device driver can be a MHI EP Networking driver or QRTR
> driver. The MHI EP controller driver is tied to the PCI Endpoint subsystem and
> handles all bus related activities like mapping the host memory, raising IRQ,
> passing link specific events etc... The MHI EP networking driver is tied to the
> Networking stack and handles all networking related activities like
> sending/receiving the SKBs from netdev, statistics collection etc...
> 
> This series only contains the MHI EP code, whereas the PCIe EPF driver and MHI
> EP Networking drivers are not yet submitted and can be found here [2]. Though
> the MHI EP stack doesn't have the build time dependency, it cannot function
> without them.
> 
> Test setup
> ==========
> 
> This series has been tested on Telit FN980 TLB board powered by Qualcomm SDX55
> (a.k.a X55 modem) and Qualcomm SM8450 based dev board.
> 
> For testing the stability and performance, networking tools such as iperf, ssh
> and ping are used.
> 
> Limitations
> ===========
> 
> We are not _yet_ there to get the data packets from the modem as that involves
> the Qualcomm IP Accelerator (IPA) integration with MHI endpoint stack. But we
> are planning to add support for it in the coming days.

s/days/months/

And now I'm going to send this, along with my comments on the first
half of the patches.  I'll keep going on the rest after that.

					-Alex

> 
> References
> ==========
> 
> MHI bus: https://www.kernel.org/doc/html/latest/mhi/mhi.html
> Linaro connect presentation around this topic: https://connect.linaro.org/resources/lvc21f/lvc21f-222/
> 
> Thanks,
> Mani
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bus/mhi
> [2] https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/log/?h=tracking-qcomlt-sdx55-drivers
> 
> Changes in v3:
> 
> * Splitted the patch 20/23 into two.
> * Fixed the error handling in patch 21/23.
> * Removed spurious change in patch 01/23.
> * Added check for xfer callbacks in client driver probe.
> 
> Changes in v2:
> 
> v2 mostly addresses the issues seen while testing the stack on SM8450 that is a
> SMP platform and also incorporates the review comments from Alex.
> 
> Major changes are:
> 
> * Added a cleanup patch for getting rid of SHIFT macros and used the bitfield
>    operations.
> * Added the endianess patches that were submitted to MHI list and used the
>    endianess conversion in EP patches also.
> * Added support for multiple event rings.
> * Fixed the MSI generation based on the event ring index.
> * Fixed the doorbell list handling by making use of list splice and not locking
>    the entire list manipulation.
> * Added new APIs for wrapping the reading and writing to host memory (Dmitry).
> * Optimized the read_channel and queue_skb function logics.
> * Added Hemant's R-o-b tag.
> 
> Manivannan Sadhasivam (23):
>    bus: mhi: Move host MHI code to "host" directory
>    bus: mhi: Move common MHI definitions out of host directory
>    bus: mhi: Make mhi_state_str[] array static inline and move to
>      common.h
>    bus: mhi: Cleanup the register definitions used in headers
>    bus: mhi: Get rid of SHIFT macros and use bitfield operations
>    bus: mhi: ep: Add support for registering MHI endpoint controllers
>    bus: mhi: ep: Add support for registering MHI endpoint client drivers
>    bus: mhi: ep: Add support for creating and destroying MHI EP devices
>    bus: mhi: ep: Add support for managing MMIO registers
>    bus: mhi: ep: Add support for ring management
>    bus: mhi: ep: Add support for sending events to the host
>    bus: mhi: ep: Add support for managing MHI state machine
>    bus: mhi: ep: Add support for processing MHI endpoint interrupts
>    bus: mhi: ep: Add support for powering up the MHI endpoint stack
>    bus: mhi: ep: Add support for powering down the MHI endpoint stack
>    bus: mhi: ep: Add support for handling MHI_RESET
>    bus: mhi: ep: Add support for handling SYS_ERR condition
>    bus: mhi: ep: Add support for processing command ring
>    bus: mhi: ep: Add support for reading from the host
>    bus: mhi: ep: Add support for processing transfer ring
>    bus: mhi: ep: Add support for queueing SKBs to the host
>    bus: mhi: ep: Add support for suspending and resuming channels
>    bus: mhi: ep: Add uevent support for module autoloading
> 
> Paul Davey (2):
>    bus: mhi: Fix pm_state conversion to string
>    bus: mhi: Fix MHI DMA structure endianness
> 
>   drivers/bus/Makefile                      |    2 +-
>   drivers/bus/mhi/Kconfig                   |   28 +-
>   drivers/bus/mhi/Makefile                  |    9 +-
>   drivers/bus/mhi/common.h                  |  319 ++++
>   drivers/bus/mhi/ep/Kconfig                |   10 +
>   drivers/bus/mhi/ep/Makefile               |    2 +
>   drivers/bus/mhi/ep/internal.h             |  254 ++++
>   drivers/bus/mhi/ep/main.c                 | 1601 +++++++++++++++++++++
>   drivers/bus/mhi/ep/mmio.c                 |  274 ++++
>   drivers/bus/mhi/ep/ring.c                 |  267 ++++
>   drivers/bus/mhi/ep/sm.c                   |  174 +++
>   drivers/bus/mhi/host/Kconfig              |   31 +
>   drivers/bus/mhi/{core => host}/Makefile   |    4 +-
>   drivers/bus/mhi/{core => host}/boot.c     |   17 +-
>   drivers/bus/mhi/{core => host}/debugfs.c  |   40 +-
>   drivers/bus/mhi/{core => host}/init.c     |  123 +-
>   drivers/bus/mhi/{core => host}/internal.h |  427 +-----
>   drivers/bus/mhi/{core => host}/main.c     |   46 +-
>   drivers/bus/mhi/{ => host}/pci_generic.c  |    0
>   drivers/bus/mhi/{core => host}/pm.c       |   36 +-
>   include/linux/mhi_ep.h                    |  293 ++++
>   include/linux/mod_devicetable.h           |    2 +
>   scripts/mod/file2alias.c                  |   10 +
>   23 files changed, 3442 insertions(+), 527 deletions(-)
>   create mode 100644 drivers/bus/mhi/common.h
>   create mode 100644 drivers/bus/mhi/ep/Kconfig
>   create mode 100644 drivers/bus/mhi/ep/Makefile
>   create mode 100644 drivers/bus/mhi/ep/internal.h
>   create mode 100644 drivers/bus/mhi/ep/main.c
>   create mode 100644 drivers/bus/mhi/ep/mmio.c
>   create mode 100644 drivers/bus/mhi/ep/ring.c
>   create mode 100644 drivers/bus/mhi/ep/sm.c
>   create mode 100644 drivers/bus/mhi/host/Kconfig
>   rename drivers/bus/mhi/{core => host}/Makefile (54%)
>   rename drivers/bus/mhi/{core => host}/boot.c (96%)
>   rename drivers/bus/mhi/{core => host}/debugfs.c (90%)
>   rename drivers/bus/mhi/{core => host}/init.c (93%)
>   rename drivers/bus/mhi/{core => host}/internal.h (50%)
>   rename drivers/bus/mhi/{core => host}/main.c (98%)
>   rename drivers/bus/mhi/{ => host}/pci_generic.c (100%)
>   rename drivers/bus/mhi/{core => host}/pm.c (97%)
>   create mode 100644 include/linux/mhi_ep.h
> 

