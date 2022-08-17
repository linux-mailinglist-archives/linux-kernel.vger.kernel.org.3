Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3763A597621
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 20:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241327AbiHQSzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 14:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiHQSzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 14:55:19 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA75C57209;
        Wed, 17 Aug 2022 11:55:18 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 18AE9581153;
        Wed, 17 Aug 2022 14:55:18 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 17 Aug 2022 14:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660762518; x=
        1660766118; bh=2MSzHf7ULCb3kZkQymVkXbgysig1iR5rZCCBOLTeyYk=; b=J
        6RpGRAB8er5OtqTwFoSv99IibnkkxQSmPTHsH6PTM0ychl74tOyhxCDoq+N3oiL3
        gWJCBrYbFwHTDFwxmKH4krAdtSjiQqYueFzQZCYcalHSYLPBijPbJ98BXAOFi03R
        NlBHluWZUf3BedagU/MrlLIjP46hHscZOZGN86WS/jL4uh3buXTUmBPUrqteSuR8
        9jpl2mkTibR15MdaUfLSs2LB1WkS8HbTjSETx46E676XnvUsGVM+qdRFRbWqAmZS
        RJRx67cxEbOZ0GqftDKHkVXJO0qs5DSzZkfciknwL6pvlU6yjKmRxoBdxCgnszRt
        h/Da8XLwjd5jj34g1C8MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660762518; x=1660766118; bh=2MSzHf7ULCb3kZkQymVkXbgysig1
        iR5rZCCBOLTeyYk=; b=fKlkXzeY3T1X6lDoHRmZyhzHI+rnwVk0dEzPZWk3EmEK
        Tc5wYnCbVprGssXbQvp6Os4phdDd24CYfvN30BXcGwqvb9lbrdWLlpuL6XGDXCSZ
        K+4qFdwKa+nbuWmHsn9Q1TtqI3bxPqNUci5aHQGngNT6uPgQCPb88VvyBLuEEffe
        MI2fgQv6+Z+zinSNHzTPdePtaOSRBu+foKS7NQ+OUjCCjDq4z6j6s8hlBVWxWLD8
        C8oKR62ZMHL7t1zlCSiEXUh2yz8VPz4P2x9BxC9E/4j12MRUDagueXcBCJ1944CW
        i33KsosNmIF+M5VAFmowuPTvJIoxjvTvTOL5HU6HHw==
X-ME-Sender: <xms:lTn9YswnFe3PqZnR5lGZ14X0fYhBRJremBOnsjJKW7qTnParAfHBCA>
    <xme:lTn9YgRWydPQquTKc10FE8TEpLoHqLX11eyzr-cG2HAu9fyYw8AcrK5gf2eLQQuY_
    _l2iIlyhEMrBwR3ygM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepgfdvueektdefgfefgfdtleffvdeileetgfefuddt
    ffelueeiveeiveekhedtheeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:lTn9YuWPEcuaC_ECqX5WKJJ_wVzuSK4LAJABqgueMMAtNEUWqcPvjw>
    <xmx:lTn9Yqhuwb9I6mQps7MD0IE2bwq5xCfalGbFh0S0b7lbvcDPIZx-IQ>
    <xmx:lTn9YuDR6l3Mu8o6I56QT_2UeX67ecWclkWA6IrJ_PkFsi3iIW9CPg>
    <xmx:ljn9Yg0YjJA_u65qyn4VKZFWV9dLfbWdsOZyjCrtXS2wP-D2dNF4Kg>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 553831700082; Wed, 17 Aug 2022 14:55:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <2f252399-0e30-4465-8c02-3f42c145174a@www.fastmail.com>
In-Reply-To: <20220817183335.47a4ao26wjopavo2@quack3>
References: <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <7c830487-95a6-b008-920b-8bc4a318f10a@applied-asynchrony.com>
 <20220817114933.66c4g4xjsi4df2tg@quack3>
 <85a141ae-56a7-4dcd-b75a-04be4b276b3a@www.fastmail.com>
 <20220817163059.kigrvdfmxfswmhls@quack3>
 <f6f899a5-97e2-460f-ad73-73d4b5e38eb6@www.fastmail.com>
 <51cd43f9-ab6b-4dd6-814f-e0c1ace3143c@www.fastmail.com>
 <20220817181554.znqljc6mmci45ukd@quack3>
 <e4c260da-2df7-49a3-a8dc-1d3fc7ca12a0@www.fastmail.com>
 <20220817183335.47a4ao26wjopavo2@quack3>
Date:   Wed, 17 Aug 2022 14:54:42 -0400
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



On Wed, Aug 17, 2022, at 2:33 PM, Jan Kara wrote:
> On Wed 17-08-22 14:18:01, Chris Murphy wrote:
>> 
>> 
>> On Wed, Aug 17, 2022, at 2:15 PM, Jan Kara wrote:
>> 
>> > OK, if this indeed passes then b6e68ee82585 ("blk-mq: Improve performance
>> > of non-mq IO schedulers with multiple HW queues") might be what's causing
>> > issues (although I don't know how yet...).
>> 
>> I can revert it from 5.12.0 and try. Let me know which next test is preferred :)
>
> Let's try to revert this first so that we have it narrowed down what
> started causing the issues. 

OK I've reverted b6e68ee82585, and removing megaraid_sas.host_tagset_enable=0, and will restart the workload...

Usually it's within 10 minutes but the newer the kernel it seems the longer it takes, or the more things I have to throw at it. The problem doesn't reproduce at all with 5.19 series unless I also run a separate dnf install, and that only triggers maybe 1 in 3 times.

-- 
Chris Murphy
