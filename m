Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A1354AECA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356137AbiFNKs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356191AbiFNKs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:48:27 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611BE49685
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:48:16 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTPS id C8C5B520712;
        Tue, 14 Jun 2022 12:48:14 +0200 (CEST)
Received: from lxhi-065 (10.72.94.27) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Tue, 14 Jun
 2022 12:48:14 +0200
Date:   Tue, 14 Jun 2022 12:48:09 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <syzbot+205eb15961852c2c5974@syzkaller.appspotmail.com>,
        <naveenkumar.sunkari@in.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] ALSA: pcm: Test for "silence" field in struct
 "pcm_format_data"
Message-ID: <20220614104809.GA4471@lxhi-065>
References: <20220409012655.9399-1-fmdefrancesco@gmail.com>
 <20220614095851.GA4199@lxhi-065>
 <2245197.ElGaqSPkdT@opensuse>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2245197.ElGaqSPkdT@opensuse>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.94.27]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Takashi, dear Fabio,

Thank you for your prompt feedback.
Please, keep me in the loop in case a revert/fix is submitted to LKML.

BR, Eugeniu.
