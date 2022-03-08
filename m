Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1694D1719
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346779AbiCHMTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346765AbiCHMSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:18:55 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6882F3207D;
        Tue,  8 Mar 2022 04:17:57 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCZ901mQhz4xxt;
        Tue,  8 Mar 2022 23:17:56 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     paulus@ozlabs.org, christophe.leroy@csgroup.eu, mpe@ellerman.id.au,
        Nour-eddine Taleb <kernel.noureddine@gmail.com>,
        benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org
In-Reply-To: <20220303143416.201851-1-kernel.noureddine@gmail.com>
References: <20220303143416.201851-1-kernel.noureddine@gmail.com>
Subject: Re: [PATCH] arch:powerpc:kvm: remove unnecessary type castings
Message-Id: <164674129469.3322453.11414816113490698694.b4-ty@ellerman.id.au>
Date:   Tue, 08 Mar 2022 23:08:14 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022 15:34:16 +0100, Nour-eddine Taleb wrote:
> remove unnecessary castings, from "void *" to "struct kvmppc_xics *"
> 
> 

Applied to powerpc/next.

[1/1] arch:powerpc:kvm: remove unnecessary type castings
      https://git.kernel.org/powerpc/c/e40b38a41ce916d6a3a4751d59a01b6c0c03afd0

cheers
