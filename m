Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89E251AD70
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356044AbiEDTJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356815AbiEDTIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:08:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA662DAA7
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651691108;
        bh=4Pe5WsHEIHx7MovZcO6xuY3dg+ajYEFZj5yDXilGQvA=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=TfSYIy8xyszJ8O1ZfcYxDpQ1YySE1EAXf3evRd+nkEYr93iiks5zkD+6lc327U/l4
         HJmEzokDBUMUniH46QLpByNAT2PQ1DMqnC+p8nCN43HrGNNQjP8lXmsgA5kGEOKSkK
         UAYkB+StoiYnQaPmJFFwgfiqqKpfao8LxP/7+HC8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.100.20] ([46.142.34.193]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmlTC-1oDAKg0WwQ-00jre2 for
 <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 21:05:08 +0200
Message-ID: <e7c0f742-522b-7e54-db4f-764c72011a86@gmx.de>
Date:   Wed, 4 May 2022 21:05:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Content-Language: de-DE
Subject: RE: [PATCH 5.17 000/225] 5.17.6-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:GxjLZu+UBxUK+BDuwlB1yujwrpCqhj4rE+uE0AmDVRO976Yl0kd
 ou0+Col9I3qUHBkyD8DimHET2ydk66CjAipl1ACcJSeZ5XymcEOtjAwgS0uL2a7+E1YsLRU
 FL3eXK3aADQKLWfz7Ja+wbIYA+VBhpPAtaxMTfwb2ZPHrmDsckxYJQ0lLpo0hIQY7J+uYw+
 qFsgBbWl5ASl8Suw4H7Vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sU6SUE+GEOU=:QI3TYtEqdZktPydAffsjZL
 9a/vYle6XkeFg1vXg/0Y1PdN26G0ba6ItQKGoZG64UMT+VWOiY6gVDtj+L+Qmr13L3cXYwg4s
 9TwmbjCpplMnz2kvQivDDrBF2AJVuIGADvjO8sy5/0qxxqywJqMvJIH63sU42Qu+YDqWn30R9
 qIv2ZnR7J9+ZHmw1cayV/0I2nDwGpIIKN61wlxBCc9w4AQVc0a4TtSDhU2SbXVKzWXP3GBOxz
 nUy7fWA/PDAF9WOjiVJhLGK85z0sU4iiGnC3deMxGcct1yA7+qI5ZDoWXIoUjKpiPx3PNiq98
 74Rq5FH/rtolhxW2yEk+Lqe2fdWMwpPABLejvHVBnfi8JgkoR5briWKQULmti+uzGC1UFCT4t
 fxr38KSoYO2dE6PYZI1xrH07mSxEHMJRsJRmTzjMTXcFI8aDnKhaNKXA6pvG1++GfLTztBdPk
 apL9eIkSkpMSXS8Zq5mLQrhb1xFXHxBM7S3JzW229cQsjU6pbb0tIFyyJw6nFmDk43MOl6UCd
 MLN1mpnNiJNLNayR28TW0BqScdkPQfydMAjpi71ATrqZc1d99IKSFqW96z7KnOn2+AxFFo5MJ
 ocTz81MGzgSep2Y7IY79PJI18oHRceninW4jcr42arKiGzP7Nk6o174/chR0HvB/AZNfYYoqv
 gZ5Mtg+Vz11Kqg56N43cGuCoC8saAV32E5kA6Z6XkthAOUj12x5SJ6Btbse5oWsBfLPNccXq9
 uA0pnb4U77N9JUd7zJCoixK+HI7OLMDc1bJKHUt2rR/U313Ua1MX2UwJHobQMVtCMDL9bwaYx
 J6rbhlL7U5k91dxHMfAoajHBhFW3WxcWEDTfEXgaL/51A4QhBsH4uf0Dus9/Z4eH7U4IRZfe9
 N32UiryOpcnGWA8eiLX2Dc7hVDXhlvBA6Y5emFXsB3e8EhdKtaGUpvhMWaU/H4AKUKDB+cDbB
 ezQ3FupiV5ybj2hywjRxO9JQpa8QFTBz42M0EiLxESyhxgyzh7UV1i8ZNOPvqw9K/OghXBFXE
 AOtdfFxHFG/QJkjGCLHgSEtpj2qnVA87eSQYwcjIG635+SrpwAZq1GBCKsMxH+b6FqUV22ht/
 zQ4Vn6pZUstFi0=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hallo Greg

5.17.6-rc1

compiles, boots and runs here on x86_64
(Intel i5-11400, Fedora 36 Beta)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de

Ronald

