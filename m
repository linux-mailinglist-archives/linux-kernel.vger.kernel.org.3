Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB1D5200A2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbiEIPEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbiEIPE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:04:28 -0400
Received: from mail-m17638.qiye.163.com (mail-m17638.qiye.163.com [59.111.176.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5A12C96E4;
        Mon,  9 May 2022 08:00:28 -0700 (PDT)
Received: from localhost.localdomain (unknown [218.85.118.195])
        by mail-m17638.qiye.163.com (Hmail) with ESMTPA id 694CA1C0545;
        Mon,  9 May 2022 23:00:26 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: Re: [PATCH] arm64: dts: allwinner: define USB3 Ethernet on NanoPi R1S H5
Date:   Mon,  9 May 2022 23:00:16 +0800
Message-Id: <20220509150016.181735-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508152505.7762-1-amadeus@jmu.edu.cn>
References: <20220508152505.7762-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRpMT01WGBoYQkgeTUsaHU
        5LVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzY6CSo4FD0yUQIvMUg3MBFK
        HzlPChxVSlVKTU5JSktDT0lNQ0lJVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlK
        Q1VDTlVKSkNVSkJOWVdZCAFZQUpMSkM3Bg++
X-HM-Tid: 0a80a955fd39d993kuws694ca1c0545
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Really? I don't have a board at hand to double check, but the code I read
> here says otherwise:
> https://source.denx.de/u-boot/u-boot/-/blob/master/board/sunxi/board.c#L791-813
> There it checks for up to four ethernet aliases and assigns MAC addresses
> to them, using the index in the lowest byte.
> So this would change the MAC address of the WiFi adapter.
> Am I missing something?

I'm very sorry for this, the rtl8189etv driver assigns the correct
mac address to wlan0, so I didn't observe the mac address change.
Sorry for my misunderstanding.

Thanks,
Chukun

