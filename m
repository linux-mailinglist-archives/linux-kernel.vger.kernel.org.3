Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9168851C84E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384629AbiEEStd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384798AbiEEStV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:49:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9456E2DF
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:43:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CD51106F;
        Thu,  5 May 2022 11:43:08 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8DBD3FA31;
        Thu,  5 May 2022 11:43:06 -0700 (PDT)
Message-ID: <7fcef16c-ef37-86da-d64c-fa2760c0e170@arm.com>
Date:   Thu, 5 May 2022 20:42:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v8 7/7] sched/fair: Remove the energy margin in feec()
Content-Language: en-US
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        vdonnefort@gmail.com
Cc:     linux-kernel@vger.kernel.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, tao.zhou@linux.dev
References: <20220429141148.181816-1-vincent.donnefort@arm.com>
 <20220429141148.181816-8-vincent.donnefort@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220429141148.181816-8-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ vdonnefort@gmail.com
- vincent.donnefort@arm.com

On 29/04/2022 16:11, Vincent Donnefort wrote:

[...]

> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>


