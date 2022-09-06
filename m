Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E28B5AE74E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiIFMLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiIFMLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:11:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DC7786C9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:11:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D016ECE1745
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A5BC433D6;
        Tue,  6 Sep 2022 12:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662466266;
        bh=iD5vnnkH4UcJ90oIy206QULA38zABVCOVMqhL/iaAcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eMeqLAnAERRjKsfVorqirrl1cjBNpOaYDKSYeI5jdk3XsQyzV7AKGDFVsMFo2vmmt
         5ue4NXiAizrw+fLjqsrI7MQEJ5k3QUKn4r2znt1dtinORki7aJVpL/a2HU85MwexYv
         FonF0lg5+wn8TaSFae6gSK/+6QOgirMhHmzW3Ryop1RA1qiDcJ5ohpzY2Vn3CkeXvG
         wv4eqkf2ozhHGzqLave6TS67xvP/Oy53UpUQCXizDJirofRAUXDGzrPxRGnc9d/eTK
         qqKXMYseZy7WHQPMoQB/vpG5p7xX3F65W5Hom3i4Q+uaZVgD/pPLS5ZADXZH4lIF37
         dmfa7pVei51wg==
Date:   Tue, 6 Sep 2022 13:11:01 +0100
From:   Will Deacon <will@kernel.org>
To:     wonder_rock@126.com
Cc:     catalin.marinas@arm.com, ardb@kernel.org, frederic@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH 1/1] arm64: preempt: Add NEED_RESCHED to the
 preempt_count()
Message-ID: <20220906121100.GD29066@willie-the-truck>
References: <20220905141829.28605-1-wonder_rock@126.com>
 <20220905155013.20118-1-wonder_rock@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905155013.20118-1-wonder_rock@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 11:50:13PM +0800, wonder_rock@126.com wrote:
> I know it is wrong. I just want to say I think preempt_count() need include NEED_RESCHED

Won't that break everybody expecting a count? I'm not sure what you're
asking from us here.

Will
