Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A4555CDFF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiF0Hcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiF0Hcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:32:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E44E5FD0;
        Mon, 27 Jun 2022 00:32:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C387CB80F4B;
        Mon, 27 Jun 2022 07:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140B7C341C8;
        Mon, 27 Jun 2022 07:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656315164;
        bh=waBdo3Lu8fG2ZJ4KsVmb+o812ilXifjsJ45IyjMIB3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JpcI8NfGJ4VeSpiVR6tmrH+1B/D8SmeCpItUEiOT0tXwS0G7hcVX0C7YtD3ElmoUj
         eQBQ3Enn2dbWJ85GiLK2rdLRMpsvvHiXkL8oxyJNnt/E1Ku1Zu6rOBjKLKX7dV4RGt
         1grLivDg5Qq5K8u93NuXCoPTyJeYjMJIUlzep6PE=
Date:   Mon, 27 Jun 2022 09:32:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: samsung-s3c24xx: Add blank line after
 SPDX directive
Message-ID: <YrldGaQFoNLcNgak@kroah.com>
References: <20220614164506.6afd65a6@canb.auug.org.au>
 <20220614084658.509389-1-bagasdotme@gmail.com>
 <9811d0e3-6c0d-6854-e654-4546fbe23860@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9811d0e3-6c0d-6854-e654-4546fbe23860@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 09:43:35AM +0700, Bagas Sanjaya wrote:
> ping

I see no context here :(
