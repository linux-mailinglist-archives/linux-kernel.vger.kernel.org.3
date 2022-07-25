Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2FE57FF43
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbiGYMre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiGYMrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:47:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFE915A1D;
        Mon, 25 Jul 2022 05:47:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 399B6B80EAD;
        Mon, 25 Jul 2022 12:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045EAC341C8;
        Mon, 25 Jul 2022 12:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658753249;
        bh=qsudKb7qDhD5skgxgIjGHUvCaHzlsnnqamDhI8iMgLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uLLaqHpk431RFpbdi2equ6oX5N9rzgMYLczJ60x10wVMBXjfEazXE0iE7vhBtIeEf
         xl2IACj+lOIj1mSFoZC37a507NYdF8TVZeum7yXp6Lo4CeeHu1g2wfdTHBMpqyENjC
         W89hg4h6sn8Q+we77W/7/QgT08xUCRvVuHdtUT6Q=
Date:   Mon, 25 Jul 2022 14:47:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 4/5] MAINTAINERS: Add entries for Toshiba Visconti DNN
 image processing accelerator
Message-ID: <Yt6Q3A4tkmu797eX@kroah.com>
References: <20220722082858.17880-1-yuji2.ishikawa@toshiba.co.jp>
 <20220722082858.17880-5-yuji2.ishikawa@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722082858.17880-5-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 05:28:57PM +0900, Yuji Ishikawa wrote:
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

No changelog text?

No signed-off-by?

Are you sure that checkpatch passed this patch?

greg k-h
