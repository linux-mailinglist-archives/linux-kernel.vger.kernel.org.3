Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC7F580C36
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbiGZHMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbiGZHMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:12:41 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77E92A975
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:12:40 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2550E669; Tue, 26 Jul 2022 09:12:39 +0200 (CEST)
Date:   Tue, 26 Jul 2022 09:12:37 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Disable guest vapic logging during early
 kdump init
Message-ID: <Yt+T5ZcvhGaK1e/h@8bytes.org>
References: <20220721003439.403435-1-jsnitsel@redhat.com>
 <Ytq2GRX7UJjvXk4w@8bytes.org>
 <a07eded4-c1d7-edf5-9c0e-dfa0c3373e4c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a07eded4-c1d7-edf5-9c0e-dfa0c3373e4c@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

On Mon, Jul 25, 2022 at 02:05:59PM +0700, Suravee Suthikulpanit wrote:
> Sorry for late reply. I have been actually working on the new GAM and GALOG enabling code,
> which should also address this issue as well. I'll send out the patch soon.

Okay, how about basing your changes on Jerry's fix? A backportable fix
for a real issue is always better than a bigger rework (which can still
happen on-top).

Regards,

	Joerg
