Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4393505E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347665AbiDRTXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238222AbiDRTXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:23:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C0A1E3C0;
        Mon, 18 Apr 2022 12:20:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42CEDB8108C;
        Mon, 18 Apr 2022 19:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BFFC385A1;
        Mon, 18 Apr 2022 19:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309654;
        bh=JkPoMATZPqYrWmJR/tP2X4yunIQyekw0+0bnzubxdDA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LkfWzKv35GijH0w5RkbjBNWBxy8ZNK8xSrpr1Cw3WJcg/JFwWeU41ZKdZH5yejwb9
         jLdNeQkJgZ7XY70lrYwCa1z2gMsGEMOL+feqSTIUz9iBBCDbKe4IIY3g4TF1fjTcxb
         38+HeXJLNNFJDKhnDtNzBAeWX1WXVB5PZFJmbQe1x1LwA8zXeIL7syKdQsxiwcx6Iv
         +dlpcfVeD1+2g3vwfb+ER4Wvqa1t1RFmI/a3zFwTgh9/4yANW85ahMT3V2zhoG2Bmz
         sDBXqOcx0F+skjSv4Fq7LvjV5Of0/P2KfLahKsvAQA8cAxLQzIxXyFYzFq+A2OBI1D
         3huqqHSPMhWFA==
Message-ID: <480a930d-8294-ddbe-6460-1a4aae319501@kernel.org>
Date:   Mon, 18 Apr 2022 12:20:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ARC: fix typos in comments
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Vineet Gupta <vgupta@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220318103729.157574-20-Julia.Lawall@inria.fr>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20220318103729.157574-20-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/18/22 03:37, Julia Lawall wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall<Julia.Lawall@inria.fr>

Applied.

Thx,
-Vineet
