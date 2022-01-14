Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83B548ED6E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242959AbiANPvU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jan 2022 10:51:20 -0500
Received: from mxchg01.rrz.uni-hamburg.de ([134.100.38.111]:35993 "EHLO
        mxchg01.rrz.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235921AbiANPvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:51:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxchg01.rrz.uni-hamburg.de (Postfix) with ESMTP id 1F9A8A14C2;
        Fri, 14 Jan 2022 16:51:15 +0100 (CET)
X-Virus-Scanned: by University of Hamburg ( RRZ / mgw04.rrz.uni-hamburg.de )
Received: from mxchg04.rrz.uni-hamburg.de (mxchg04.rrz.uni-hamburg.de [134.100.38.114])
        by mxchg01.rrz.uni-hamburg.de (Postfix) with ESMTPS;
        Fri, 14 Jan 2022 16:51:15 +0100 (CET)
X-Virus-Scanned: by University of Hamburg ( RRZ / mgw04.rrz.uni-hamburg.de )
Received: from exchange.uni-hamburg.de (UN-EX-MR08.uni-hamburg.de [134.100.84.75])
        by mxchg04.rrz.uni-hamburg.de (Postfix) with ESMTPS;
        Fri, 14 Jan 2022 16:51:15 +0100 (CET)
Received: from plasteblaster (89.244.206.161) by UN-EX-MR08.uni-hamburg.de
 (134.100.84.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 14 Jan
 2022 16:51:14 +0100
Date:   Fri, 14 Jan 2022 16:51:13 +0100
From:   "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
To:     <akpm@linux-foundation.org>
CC:     Balbir Singh <bsingharora@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] taskstats: version 11 with tgid
Message-ID: <20220114165113.27e4bd08@plasteblaster>
In-Reply-To: <20220110194417.147d4eff@plasteblaster>
References: <20220110194417.147d4eff@plasteblaster>
Organization: =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg
X-Mailer: Claws Mail (x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [89.244.206.161]
X-ClientProxiedBy: UN-EX-MR07.uni-hamburg.de (134.100.84.74) To
 UN-EX-MR08.uni-hamburg.de (134.100.84.75)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andrew Morton,

I am trying to get my taskstats updates noticed since 2018 now. Balbir
Singh does not seem to be active/responding at the mail address that

	scripts/get_maintainer.pl kernel/taskstats.c

produces. The guide at

	https://docs.kernel.org/process/submitting-patches.html

suggests that I should bother you directly in that case. May I kindly
point to the two patches that I'd like to have reviewed and hopefully
included?

These are the two patches in the LKML archive:

https://lkml.org/lkml/2022/1/10/1136
https://lkml.org/lkml/2022/1/10/1135

I hope they are trivial enough, in the end.


Alrighty then,

Thomas

-- 
Dr. Thomas Orgis
HPC @ Universität Hamburg
