Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469E54B3821
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 22:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiBLVB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 16:01:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiBLVBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 16:01:24 -0500
Received: from biche.re (biche.re [IPv6:2607:5300:201:3100::6c88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73D2D3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 13:01:19 -0800 (PST)
Date:   Sat, 12 Feb 2022 22:01:12 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 biche.re 1396F40617
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=biche.re; s=biche;
        t=1644699675; bh=qt2OQlf2eNHyy4Rr7O8K2qYNm+v84dIqyVBhQttppkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U21Qj3kMDmGoZPF/KMbRJsXuKvxZFM9PpKTRH5EzaUXVjSeMApeV+J9IEQHSEngUx
         tU1W7w8xnCPvl3HG7809KZw0NkxDNy+1e5EcjTG3in/rrIJ5fjkzd9DOhihFs0IK+2
         gQUnV3dgGTAQ7j5oB8V++TWPkCUw/9z751UgQyv01LjIrBs3pvVUfq+XpEHaGHMk6z
         nwRlnb9dIFcLu+kBBBAMfvs2gwSqYIokOAk7PHGsvdaOGYxBsYM26EEOL4wLTPEzo/
         9ec+nz+wDa7XcvOppD9fl3MCztZAHcbGmioavvo6+D9FPVAhfaEyOR8yqtYLzg8Sq+
         aKE0j7YV++Wsg==
From:   Victorien Molle <biche@biche.re>
To:     linux-kernel@vger.kernel.org
Cc:     Victorien Molle <biche@biche.re>
Subject: Re: [PATCH] KVM: x86: Add support for basic RAPL (Running Average
 Power Limit) metrics
Message-ID: <YgggGG92eMCzdomb@ultrahax>
References: <20220109182317.1075762-1-biche@biche.re>
 <YfKCLAdwh0LZXIDz@ultrahax>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfKCLAdwh0LZXIDz@ultrahax>
X-Operating-System: Winux 5.15.0-2-amd64 13.37
X-Message-Flag: Bonjour =?iso-8859-1?Q?=E0_toute?= =?iso-8859-1?Q?s?= les
 biches !
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SCC_BODY_URI_ONLY,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping https://lore.kernel.org/all/20220109182317.1075762-1-biche@biche.re/T/#u
