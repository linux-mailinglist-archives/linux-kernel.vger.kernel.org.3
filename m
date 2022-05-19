Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F123A52D6B7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240241AbiESPBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240539AbiESPBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:01:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFEADE300
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 660DFCE24FB
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD7FC385AA;
        Thu, 19 May 2022 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652972414;
        bh=rOtKjvujeYLjP/1zOHTzQkBYVqV1bHSM6AhwN9ndMzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6nmuph1RYBSK+RWpyPY2vKADbX30Oret6BFzO0g11vUIrKxhXdxTWhTZh3Vqea7+
         I88z49DVD88xPNNKtoyLdGCAIWKIpEaypFdXqk6yXCfwmem8ZljHKvj98r1I2vClDN
         5TXCR7y1e0GyUoUfvthtTxMwo2qJ0Qujssom8fkQ=
Date:   Thu, 19 May 2022 16:56:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <chanwoo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for 5.19
Message-ID: <YoZagTAVe1WQb6n+@kroah.com>
References: <eaab9f4d-06d4-3ddc-3756-69f762bd86e1@gmail.com>
 <3aa73483-19d6-fc25-a3c6-03343582b542@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa73483-19d6-fc25-a3c6-03343582b542@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:03:48AM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> Gently ping. Could you please pull this request?

Sorry, was behind in patches, catching up now...

