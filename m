Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92185501BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345657AbiDNTfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240972AbiDNTfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:35:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 611D7ECC70
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:32:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0322712FC;
        Thu, 14 Apr 2022 12:32:50 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C26B23F70D;
        Thu, 14 Apr 2022 12:32:48 -0700 (PDT)
Message-ID: <3b952d2d-3f41-e5dc-be2f-c58a5083e195@arm.com>
Date:   Thu, 14 Apr 2022 21:32:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 0/7] feec() energy margin removal
Content-Language: en-US
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com
References: <20220412134220.1588482-1-vincent.donnefort@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220412134220.1588482-1-vincent.donnefort@arm.com>
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

On 12/04/2022 15:42, Vincent Donnefort wrote:

Nitpick: s/v3/v4 in cover letter

> find_energy_efficient() (feec()) will migrate a task to save energy only

s/find_energy_efficient/find_energy_efficient_cpu

[...]

LGTM. For the whole patch-set:

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
