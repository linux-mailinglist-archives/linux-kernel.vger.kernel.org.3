Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CD15416CD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 22:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378282AbiFGU4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 16:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358950AbiFGTxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 15:53:24 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18E99FE7;
        Tue,  7 Jun 2022 11:23:08 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 06FE95C0194;
        Tue,  7 Jun 2022 14:23:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 07 Jun 2022 14:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1654626186; x=
        1654712586; bh=A2Qz84RTtLj12xCCvGD9YEnpJpWvd/IEQH37atiAywk=; b=X
        tbU6xTVF1e6z2o3FN1AzPdanm+UDnIeBx7vn1QLtuWEnbnGiMPgdhWtP/c1fmgpK
        004ApcGLooLI7mD6nopG4fsyDdxSMu/4g1FO0ByLyHWwL+634Cpd1HHaWCOlzpk6
        kmERRs1qNXZcpYE0PH9+DOwWH1+wPWrLXv8Jfc4mB+1fERLqt21U5d2klW9Y3kGz
        A8p6VcLtarAYnWppvzlEPbwJZSIiU7gX2ha12zYRRds/sxtFtIT+fYGtPL38PRP4
        0SxTMCuauskKc7TGZBeIBLIIpg3dObujvsbbmrY3XiGCvr5BbtoSoX0OzSMaRLAc
        DXsCOR7MLfymF1nrGTHCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1654626186; x=
        1654712586; bh=A2Qz84RTtLj12xCCvGD9YEnpJpWvd/IEQH37atiAywk=; b=g
        fLKM3cRy6/bvh/Dqt1bbAAlSs0ZatAyOwikb2xZZ4Ue2wY5QtTG5rH6HBi0hgRIJ
        23F3e7NWnjtASVeAJrGVjWrd90ZnVPTiRVOQ2KpQIttfyfSKHDUM0OhD1QddWcMB
        0ckGVBdGdD4dYl2l9zjo67PoPF+gmPIy3wqm0MpBgx1HRe6d5+L9SwlkEdbHrrUb
        W/RDqcd+fZWSi142cWIXuaHOXWqGDH6QV4Dy/yQ39kGY2abytrMWw0RCdRc1kCcC
        mDsg8sAu9W7zY7acv1+BEEi3DGhVwjZIkqIv/VAI9bbtmXZppstjlS+qnx9d6XuY
        ZtElA3ttKP4Veyp7aP7WA==
X-ME-Sender: <xms:iZefYt_QKzDJuI_H55srUQAfZGO8B0M0Z1VLadyQlULjsW-RehIHnA>
    <xme:iZefYhtl2he6-5PYj6hWXsVcjwV7Ir9FIoNeJQbMohf6m4oOz9VvW1jOAvPTUeXCu
    Apn6hhEftboVnbnkqQ>
X-ME-Received: <xmr:iZefYrCmF_VHwHeTDqLYqPdV6cwmkoVT_8V6BjolPePgMF_SrCqhcw5tktIJjNxd3I_F36lMQJWdL23VD5DeKjcyUZ-wHR27mCkGNV2mUjI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeduhfekvedvtdeukeeffefgteelgfeugeeuledttdeijeeg
    ieehvefghefgvdefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:iZefYheF9ykhy5_RZ6_CqR_rdhJTRuFslz0YfXy6CyBzWnAJEY7JQQ>
    <xmx:iZefYiMZbh-Ls7dCaRNDExiQOVcEkqWfjPEPSEeutBgAJVpRXWa5ig>
    <xmx:iZefYjnCoFPlabAcaI_-FgTQ7mlDPdkAOhRKO9dc6ps1XCweHByBeg>
    <xmx:ipefYpmvM1CzWnBpEp_HBfSJX55iED9u7NTjrtpS52HzqlZqYmwJRQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jun 2022 14:23:03 -0400 (EDT)
Message-ID: <0a5dd632-0607-dab6-4de7-1ea248490863@flygoat.com>
Date:   Tue, 7 Jun 2022 19:23:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 06/12] irqchip: mips-gic: Multi-cluster support
Content-Language: en-GB
To:     Marc Zyngier <maz@kernel.org>,
        Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
References: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
 <20220525121030.16054-7-Dragan.Mladjenovic@syrmia.com>
 <87wndu3tff.wl-maz@kernel.org>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <87wndu3tff.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/6/6 12:47, Marc Zyngier 写道:
> On Wed, 25 May 2022 13:10:24 +0100,
> Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com> wrote:
>> From: Paul Burton <paulburton@kernel.org>
>>
>> The MIPS I6500 CPU & CM (Coherence Manager) 3.5 introduce the concept of
>> multiple clusters to the system. In these systems each cluster contains
>> its own GIC, so the GIC isn't truly global any longer. We do have the
>> ability to access registers in the GICs of remote clusters using a
>> redirect register block much like the redirect register blocks provided
>> by the CM & CPC, and configured through the same GCR_REDIRECT register
>> that we our mips_cm_lock_other() abstraction builds upon.
>>
>> It is expected that external interrupts are connected identically to all
>> clusters. That is, if we have a device providing an interrupt connected
>> to GIC interrupt pin 0 then it should be connected to pin 0 of every GIC
>> in the system. This simplifies things somewhat by allowing us for the
>> most part to treat the GIC as though it is still truly global, so long
>> as we take care to configure interrupts in the cluster that we want them
>> affine to.
> I can see how this can work for level interrupts, but how does this
> work for edge interrupts? Is there any guarantee that the interrupt
> will be discarded if routed to a cluster where it isn't configured?
It is supposed to mask the interrupt out on the GIC which belongs to the
cluster that the interrupt is not routed to.

When it's masked out GIC simply won't sense any level change.

I guess it's sort of guarantee?

Thanks
- Jiaxun

>
> Otherwise, I can imagine plenty of spurious interrupts on affinity
> change.
>
> Thanks,
>
> 	M.
>

