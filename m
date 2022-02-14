Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673354B4072
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbiBNDmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:42:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240068AbiBNDmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:42:22 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F0155BEF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 19:42:15 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9F15B580218;
        Sun, 13 Feb 2022 22:42:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 13 Feb 2022 22:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=JEibxPGvz4zlvz
        8cnCgwsSaVEcxlPUvz1ybP2YVe2lw=; b=I5wIQ5mnPRhiGXUuQ5NkhC/FzDfS0R
        8fAA0gG1hjZGSvhsgvrJeGhM3o/9QvE5RD8nLaDxIdgED9yOlpsJNv2ZKxQejCVK
        Qwp7M2YdhVPEnxbIgm8sHBq7kMNDgBKtgr8KXGgU6K5uzyR3nhwN4ZxymO1GzMSd
        OLVDLrO0fxSx4ZxqhrMI1FHABal3UQlA6RyzyvG05a3KYsHIepiysrhWOmW9SiMt
        K+pkGbgcA4MUiLWA2bZ1VT/XhMmP8sb+kypG2U06IFMyji3fNGP8q/IDD6+Dh3bV
        YOFQw7BkNrHgc5+59aSjhK6Bz+BnlkqV+w57Wa8EPmq9EltpRb829Feg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=JEibxPGvz4zlvz8cnCgwsSaVEcxlPUvz1ybP2YVe2
        lw=; b=UEJaJz8SjMfnmljMJTY+Rkas67dWAiQF88GmhwQuUEVinalhmW1pMnUDa
        rYzl90E0rWFAK1mx6VAq8G1Oh2ozQ2RhMS0i6sD32j2gtAGlRi54/R8gWJiUeF9o
        xfrNKL4gXNcpRrDyNJwoE4rGG9SA/SmttoSVAWm3LzbHM5jh0Z7z6yLj1FLL3hcU
        +2LkZEPO0OKDUd/QOu1+nVb7N17YjIF5XUo/W22/krAA5NEQEedU4ChYNbmFurD2
        TSPwptED95gwh2pn3gkdgDlbI7Zbiv4EDG+UJ7ABK0nxMHAF28NwupOtKmYnqop7
        h8DSPLv9N2/76gQvNvZnMYodNqN1Q==
X-ME-Sender: <xms:lM8JYkN5kh3nhaAOhB1TJimIF3LmXPrlpVpoMcEOPR4hGGAOlqN5Kw>
    <xme:lM8JYq_vCVxhCRkoKlkfSOBY0l548IBdpyVBqDtu5DIx3n_W4n-RouMnARnpHKu38
    FigdL29sudWQJ-O7Q>
X-ME-Received: <xmr:lM8JYrSfRszXnqyYZ0jf5bz0NgkvepYpRtlW_dXNo1cVw6Ig8dxPkULf_T36XqcRxQvPJbTURRIojSojcC4t77_jDhbf-ofYwao_rsvNgFnxU_xmC8_DcbHUIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjedugdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:lc8JYssjYQThyR8pU_bHiJfk-tsnG2muWnIl2j4u6n8GvKijTGk_Og>
    <xmx:lc8JYsdj7GgEKVoSL45LvQPDiVWsXiNlYdhC7t8yZtyj_iw6CLwGSQ>
    <xmx:lc8JYg3ipRwLyyUgAJ0Z4hJHDZJZ99_lXkKMw203rEvUHQuuZay9rQ>
    <xmx:ls8JYlMZC8CUIWe7QlfpHlGy8qd0_udfZJuldURA_j3LkPJVmNjFgQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Feb 2022 22:42:11 -0500 (EST)
Subject: Re: [PATCH v6 14/14] riscv: add memory-type errata for T-Head
To:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, huffman@cadence.com,
        mick@ics.forth.gr, allen.baum@esperantotech.com,
        jscheid@ventanamicro.com, rtrauben@gmail.com, cmuellner@linux.com,
        philipp.tomsich@vrull.eu
References: <20220209123800.269774-1-heiko@sntech.de>
 <20220209123800.269774-15-heiko@sntech.de>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <0f5e7f77-abe9-046e-7296-2f22cb7e5b86@sholland.org>
Date:   Sun, 13 Feb 2022 21:42:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220209123800.269774-15-heiko@sntech.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 6:38 AM, Heiko Stuebner wrote:
> Some current cpus based on T-Head cores implement memory-types
> way different than described in the svpbmt spec even going
> so far as using PTE bits marked as reserved.
> 
> Add the T-Head vendor-id and necessary errata code to
> replace the affected instructions.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Samuel Holland <samuel@sholland.org>
