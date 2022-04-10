Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EAB4FAFC3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241552AbiDJTXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 15:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbiDJTXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:23:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDF760D8F;
        Sun, 10 Apr 2022 12:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649618436;
        bh=Um2CyqQauVqupQHiyn/GAWvh9ii4MDarJZuw1tAtqek=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VOZ5ehyj24L/Zfm6o/cOTxIiDpp2nra2nXckq7zqXFpUtoT2Ab6+jyYK+IUBQIGzV
         mqsyhI0FyAoWINfI6UApn1/kzzs8REuc4eqk6esWAj/D1aIeWR/huWFP0Y0pROVc4v
         Bb3wuez9OV+TlQ1DamScAlKLpwIkG3gN8ILFHUZQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.146.192] ([217.61.146.192]) by web-mail.gmx.net
 (3c-app-gmx-bap63.server.lan [172.19.172.133]) (via HTTP); Sun, 10 Apr 2022
 21:20:36 +0200
MIME-Version: 1.0
Message-ID: <trinity-4dcbfdf3-ae12-4d36-ac7a-8df929478eb0-1649618436606@3c-app-gmx-bap63>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Peter Geis <pgwipeout@gmail.com>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Aw: Re: [PATCH] usb: dwc3: fix backwards compat with rockchip
 devices
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 10 Apr 2022 21:20:36 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <12992587.uLZWGnKmhe@phil>
References: <20220409152116.3834354-1-pgwipeout@gmail.com>
 <12992587.uLZWGnKmhe@phil>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:l7bLbLxORt8ivEQrcCx7kspHK4Lr3Iaz1Zn4/S09eTzu7DNQR8Ni/GY0dy0rV7EQgBXFo
 L7V6/RkMNe5Tw79nSyuXw6axT9XtK1amrOGm5enTJ1Sn7fXFmhhVQLPpP9yuxUzC7f8TFJflXL6S
 /KC4YxbZN0DUSN7RlvKRXiXBlgZXiMhb5wpxzIhYjFY8mDXMcwKeTbhHgCeiE9hfiyi0G9D98NOD
 DKzokDlKl8oIJf2LdT/JgPkU+Oo28ikB3xAbGsgDH4PVp2A+cUrNqALmY9a+5gbJrMLLzbIRVE7b
 4g=
X-UI-Out-Filterresults: notjunk:1;V03:K0:edowQyZyc/Y=:2USGISP2Y2Je8pHsFl49RB
 dFI5CulvvgJZZdvDJ5xzGi7WCL9gipAOXphqUoqkABkSa1eztAYvDt0OOhFGbHJ6Xs9+tMqo9
 g3qnBLywoVMUZss5x42MBr+EyJM+oelMpNmw25ncTxNaesW9NuaY/l1KEIrrxNcH4oLtnguef
 VceEJ3apQu+NAXlvfMzgm3NOn5BZBaBMK44YPTlCa7wb4UK8eN1j0Z/QDEprRUBr1Q2vVFIXp
 UmYFi+YsJOZU2bHc9Fs3uwAK3pFDgGmBfqZSj+oJE56m9RMG90wJLq20L0AJ/qts4nJrfh7UL
 Z9bdoHnm5TvEABLni9HebsaELy1b4bhXZyNoD9a/oXbXORwUFE+SOmarQFpwbVRLoCeRFP6Yv
 7dgYIonARRlQ4eqOzsUJ01x9cL15ACGh6sdO1U4uMpWtxLgGsQ3lv3/cEx+Axe19JOAFuc/7G
 YwJkr5o5+zOvsbrfcw2rkVYb9qUWrvkQgZvt+3yJJIv/fO7/EmP+wlDBUbFNtFKq41/PERSUY
 nQDkqD02C61+vxL7S0wAUWWVkoRMpcshAzpcoulyds17wm47jvRfVjeRqZfjojlfQAw3Qab8H
 rO8ByYBlRRN2WiC2JJcidVhBB3jmCE+suVmZgncLl4XOhMAno9YVIjiHGcN4nePhHLjYp6Fc4
 h9u43TR9LCo67Cj4afeWCE6l9u+idYLuEk1nuAqyPXUp5GAyv6cC8QKUm9mqCuetWD1u5cozQ
 laBlPzwiHGuorjjnOjFzG2Ni+UlOWClsAre+aY7b70mkdzFDHKZdD90s6pa6rW+PkKSeVWFNk
 Lry/3Oj
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on rk3568 Bpi-R2 Pro V1.0 with RK356x USB-Support [1] and BPI-R2-Pro USB Support [2]

Tested-By: Frank Wunderlich <frank-w@public-files.de>

regards Frank

[1] https://patchwork.kernel.org/project/linux-rockchip/list/?series=630470
[2] https://patchwork.kernel.org/project/linux-rockchip/list/?series=630686
