Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D544255D1FB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244740AbiF1LHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345302AbiF1LHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:07:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194AD31230;
        Tue, 28 Jun 2022 04:07:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDD75B81DD1;
        Tue, 28 Jun 2022 11:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0ECC3411D;
        Tue, 28 Jun 2022 11:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656414441;
        bh=3eko6/GH1XdMdAFPhxnypHJyEn42b4Rtn9jq+UXSoX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q+FIGnNq34+rLxRTbqWl4nOlXlhVX8tFquNV20lN6wWmc783px+7gzZ6oblfZIqzD
         stD+F/KqTKydlWE7RmeCvj0STvrloQgM9AmF8zJnU2n93WqBxfRu95YGERbzTdrpJ4
         6NF6Dtx7wiyPZZB7hv53+G0ITLZKLgD11tf4C49rcRdKV7PjG0+GU8Q7GFcld3uW2G
         MnCY/JFUupTgeyLFXIA4+d6bsUqvy5lx5dtOMkNiQR++VWYpaAnhqKPmbVvRgmKcBI
         Dtgl5ccGxiBb1+BVZgp73OYqcfA42OFUGOk/F/nb8v33qTTrW0waFxdBpv6wUBsI4w
         wF85HLCQ9SBhg==
Date:   Tue, 28 Jun 2022 12:07:15 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/22] regulator: fix a kernel-doc warning
Message-ID: <20220628120715.36080b8b@sal.lan>
In-Reply-To: <YrrZVDUXzHNtvLNi@sirena.org.uk>
References: <cover.1656409369.git.mchehab@kernel.org>
        <15efc16e878aa327aa2769023bcdf959a795f41d.1656409369.git.mchehab@kernel.org>
        <YrrZVDUXzHNtvLNi@sirena.org.uk>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 28 Jun 2022 11:35:00 +0100
Mark Brown <broonie@kernel.org> escreveu:

> On Tue, Jun 28, 2022 at 10:46:22AM +0100, Mauro Carvalho Chehab wrote:
> > document n_ramp_values field at struct regulator_desc, in order
> > to solve this warning:  
> 
> This is patch 18 of a series for which I don't have a cover letter or
> anything.  What's the story with dependencies here?

There are no dependnecies. Each patch in this series is independent,
touching different files.

Regards,
Mauro
