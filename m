Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B6D482E87
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 07:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiACGsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 01:48:10 -0500
Received: from 6.mo548.mail-out.ovh.net ([188.165.58.48]:33943 "EHLO
        6.mo548.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiACGsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 01:48:09 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.84])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 3640B207C9;
        Mon,  3 Jan 2022 06:41:15 +0000 (UTC)
Received: from kaod.org (37.59.142.96) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 3 Jan
 2022 07:41:14 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-96R0010519d886-6aaf-4337-bfe0-c5278666afd4,
                    2FB4A63B976BE1634B5E5BEF676EDDCED9FE10A5) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <4d03fc5f-8c0a-96d0-da83-17d7a019ab58@kaod.org>
Date:   Mon, 3 Jan 2022 07:41:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] powerpc/xive: Add missing null check after calling
 kmalloc
Content-Language: en-US
To:     Ammar Faizi <ammarfaizi2@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Yang Li <yang.lee@linux.alibaba.com>
References: <20211226135314.251221-1-ammar.faizi@intel.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20211226135314.251221-1-ammar.faizi@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 2e5ada26-2a7c-476c-84a3-c0e1a5e66fc8
X-Ovh-Tracer-Id: 11135994504318192489
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrudeftddgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepieegvdffkeegfeetuddttddtveduiefhgeduffekiedtkeekteekhfffleevleelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopeihrghnghdrlhgvvgeslhhinhhugidrrghlihgsrggsrgdrtghomh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/21 14:54, Ammar Faizi wrote:
> Commit 930914b7d528fc ("powerpc/xive: Add a debugfs file to dump
> internal XIVE state") forgot to add a null check.
> 
> Add it.
> 
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Fixes: 930914b7d528fc6b0249bffc00564100bcf6ef75 ("powerpc/xive: Add a debugfs file to dump internal XIVE state")
> Signed-off-by: Ammar Faizi <ammarfaizi2@gmail.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.
