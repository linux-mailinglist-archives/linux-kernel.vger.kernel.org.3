Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9466C59756E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 20:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240881AbiHQR52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiHQR5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:57:25 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C928E47E;
        Wed, 17 Aug 2022 10:57:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id DDBB7580D8B;
        Wed, 17 Aug 2022 13:57:21 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 17 Aug 2022 13:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660759041; x=
        1660762641; bh=6KjITppIDlmj3qAAJAmkZAm9wDlh00j0GBP4rkiftaE=; b=B
        +D3Uk/5wBHDunpIxtqE3nhhYM//NqC6r9EV3BARDWxhBVCVaTUzOVguxR0YElOVl
        EuzZkmFIEc1pwXVH60ovuZbRXJwiUOoGbmx6zNc1UsC9oFZIG6CAfHRqkvVQWbbt
        NCZhfz7erIoSDf2I9JfULsckh7a6bI49KV6+mLS/c12y4dgKN8oshTST2Q68oATE
        lgu9dPGfavGX9SJ42MHNxGcS2TlN8jT/EmAKKuQU7aOBQwCMQd6JbYSqQ2Tqo1qN
        dmtbxDuNxOtimxpu0fq7ipcLa0aI93dfxkXL8AkZ5qVcfNqT4KjPgtYX+7EEAvQG
        oZnipc1QNzahkgJ3YdVVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660759041; x=1660762641; bh=6KjITppIDlmj3qAAJAmkZAm9wDlh
        00j0GBP4rkiftaE=; b=NCRY6jDAg6sxgBnaBeaBWxcX+bWFbW0bnnt+OkZ6nBAT
        ESowbJCaMOQ5mb4F+dAb0NlEJJiVvGi9gMycAeNGa9i1iL6kk9y5P3z1vLrNvr55
        IMfyEd+EsfI2Lm2AtyYlaBB5nx/PXNfioFJUFUhYZPqwLXPkhGuttkkP1bHg6QTJ
        GPneq2pJHHDQJWHPC2aUfSSMXq8yNbRaYajQJyK3T0XGGArI9qYGh/CT69sD0KGU
        T/p9vUacpbmlzsgYXIFYul2DRfPmtRKGVrORxaobKwQ3j4Gh7CnZqHOUY9MXw77I
        MuiB7+jnqcBv6Xg/a8QLwfTNe+B9ar92X4+J5gUd7g==
X-ME-Sender: <xms:ASz9YkIuc-q3RxBjCBqsxfNCkAshUBPqJE1mjq4mofv9JJ78dv0pSA>
    <xme:ASz9YkIaaHfByyKOj-XFEYLWPvfuI5DbVF2UNbV_HYuOFaQjr0-LYWaj8MV7qSBqw
    XoxMs0JSwDYgE10LJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepgfdvueektdefgfefgfdtleffvdeileetgfefuddt
    ffelueeiveeiveekhedtheeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:ASz9YkvSIsd4emdq2hdbiYrllRSsxSI-kIKQh-g0_AzrMLxtOYvTlw>
    <xmx:ASz9YhZYyj5rMu6Ibrc0_4E4LGPmo-jTQs3UrxFSA65ANhpSSbD2NA>
    <xmx:ASz9YrYJ1wuOZF5uOpbDfz8as0108VtsE2we72MI_BIr4WZqXAyixQ>
    <xmx:ASz9YgOo8M5jUx_kSVtZaFZNerJw9ujo_1U5mB7m5EWFuzbWHmtBmg>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1A6C01700082; Wed, 17 Aug 2022 13:57:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <51cd43f9-ab6b-4dd6-814f-e0c1ace3143c@www.fastmail.com>
In-Reply-To: <f6f899a5-97e2-460f-ad73-73d4b5e38eb6@www.fastmail.com>
References: <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
 <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
 <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <7c830487-95a6-b008-920b-8bc4a318f10a@applied-asynchrony.com>
 <20220817114933.66c4g4xjsi4df2tg@quack3>
 <85a141ae-56a7-4dcd-b75a-04be4b276b3a@www.fastmail.com>
 <20220817163059.kigrvdfmxfswmhls@quack3>
 <f6f899a5-97e2-460f-ad73-73d4b5e38eb6@www.fastmail.com>
Date:   Wed, 17 Aug 2022 13:57:00 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Jan Kara" <jack@suse.cz>
Cc:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        "Nikolay Borisov" <nborisov@suse.com>,
        "Jens Axboe" <axboe@kernel.dk>,
        "Paolo Valente" <paolo.valente@linaro.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Aug 17, 2022, at 12:47 PM, Chris Murphy wrote:
Can you boot with
>> "megaraid_sas.host_tagset_enable = 0" kernel option and see whether the
>> issue reproduces?

This has been running an hour without symptoms. It's strongly suggestive, but needs to run overnight to be sure. Anecdotally, the max write IO is less than what I'm used to seeing.

[    0.583121] Kernel command line: BOOT_IMAGE=(md/0)/vmlinuz-5.12.5-300.fc34.x86_64 root=UUID=04f1fb7f-5cc4-4dfb-a7cf-b6b6925bf895 ro rootflags=subvol=root rd.md.uuid=e7782150:092e161a:68395862:31375bca biosdevname=1 net.ifnames=0 log_buf_len=8M plymouth.enable=0 megaraid_sas.host_tagset_enable=0
...
[    6.745964] megasas: 07.714.04.00-rc1
[    6.758472] megaraid_sas 0000:02:00.0: BAR:0x1  BAR's base_addr(phys):0x0000000092000000  mapped virt_addr:0x00000000c54554ff
[    6.758477] megaraid_sas 0000:02:00.0: FW now in Ready state
[    6.770658] megaraid_sas 0000:02:00.0: 63 bit DMA mask and 32 bit consistent mask
[    6.795060] megaraid_sas 0000:02:00.0: firmware supports msix	: (96)
[    6.807537] megaraid_sas 0000:02:00.0: requested/available msix 49/49
[    6.819259] megaraid_sas 0000:02:00.0: current msix/online cpus	: (49/48)
[    6.830800] megaraid_sas 0000:02:00.0: RDPQ mode	: (disabled)
[    6.842031] megaraid_sas 0000:02:00.0: Current firmware supports maximum commands: 928	 LDIO threshold: 0
[    6.871246] megaraid_sas 0000:02:00.0: Performance mode :Latency (latency index = 1)
[    6.882265] megaraid_sas 0000:02:00.0: FW supports sync cache	: No
[    6.893034] megaraid_sas 0000:02:00.0: megasas_disable_intr_fusion is called outbound_intr_mask:0x40000009
[    6.988550] megaraid_sas 0000:02:00.0: FW provided supportMaxExtLDs: 1	max_lds: 64
[    6.988554] megaraid_sas 0000:02:00.0: controller type	: MR(2048MB)
[    6.988555] megaraid_sas 0000:02:00.0: Online Controller Reset(OCR)	: Enabled
[    6.988556] megaraid_sas 0000:02:00.0: Secure JBOD support	: No
[    6.988557] megaraid_sas 0000:02:00.0: NVMe passthru support	: No
[    6.988558] megaraid_sas 0000:02:00.0: FW provided TM TaskAbort/Reset timeout	: 0 secs/0 secs
[    6.988559] megaraid_sas 0000:02:00.0: JBOD sequence map support	: No
[    6.988560] megaraid_sas 0000:02:00.0: PCI Lane Margining support	: No
[    7.025160] megaraid_sas 0000:02:00.0: megasas_enable_intr_fusion is called outbound_intr_mask:0x40000000
[    7.025162] megaraid_sas 0000:02:00.0: INIT adapter done
[    7.025164] megaraid_sas 0000:02:00.0: JBOD sequence map is disabled megasas_setup_jbod_map 5707
[    7.029878] megaraid_sas 0000:02:00.0: pci id		: (0x1000)/(0x005d)/(0x1028)/(0x1f47)
[    7.029881] megaraid_sas 0000:02:00.0: unevenspan support	: yes
[    7.029882] megaraid_sas 0000:02:00.0: firmware crash dump	: no
[    7.029883] megaraid_sas 0000:02:00.0: JBOD sequence map	: disabled
[    7.029915] megaraid_sas 0000:02:00.0: Max firmware commands: 927 shared with nr_hw_queues = 1
[    7.029918] scsi host11: Avago SAS based MegaRAID driver




-- 
Chris Murphy
