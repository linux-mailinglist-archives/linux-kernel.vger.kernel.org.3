Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A547753FFCF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244535AbiFGNQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243382AbiFGNQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:16:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D59F338A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:15:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D97AB81C97
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 13:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54890C385A5;
        Tue,  7 Jun 2022 13:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654607757;
        bh=2fb486ZWcuFaA673rIFGIDVqeQ4KrWj/5hmN64DTg5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fbDY8ELhIJHTk7l01bZEhx5U3OvN4mEqXxZACXGGdb7Ua4VqOsJfY0/Y8M3zUWIKj
         pDeO/PVz5aNXgc6H1b9PW1vydVXHPcEWmPU+XC7Btz4YDtRAmtfFG/j23Q9V9xqyM1
         CYcVINYHtril6QuBJlZJdIcWghkwy7LmA1Wel7to=
Date:   Tue, 7 Jun 2022 15:15:51 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Paris Andrea <aparis@student.ethz.ch>
Cc:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: r8188eu: remove multiple blank lines
Message-ID: <Yp9PhzQlQG36lx9L@kroah.com>
References: <a547d8a1b1914a86a35c488160f8c833@student.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a547d8a1b1914a86a35c488160f8c833@student.ethz.ch>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 01:14:22PM +0000, Paris  Andrea wrote:
> This patch removes three blank lines after a variable declaration in the file rtw_cmd.c
> in order to fix the three related checkpatch warnings.

That is not what this commit does :(

