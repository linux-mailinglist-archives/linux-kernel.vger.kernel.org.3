Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426155915AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbiHLSxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbiHLSxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:53:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC5012083;
        Fri, 12 Aug 2022 11:53:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A9B86175E;
        Fri, 12 Aug 2022 18:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673FDC433D6;
        Fri, 12 Aug 2022 18:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660330399;
        bh=Isq46jtT9saMIvYaavTN6TUWCvUM3dZVDN8O/L7fbqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=szow6uk4k9Ys6Cdtd3k1SwzfPTtB0X1cRJgrb8D93bQFK9elYsSq2RDMc0UL6a0Hu
         crlB3FQTFyqpdgKRpNNPddmOYYKB5OwrcsxjfQQ36XcwUcyRXoAKd0Y3PXu29Wl4XG
         BWxBC7KlsjktfzITIKTI5F6DUHJRVPtriF6TQcCwCV0CEu0atjpF9Q4Dgk+px/kT4c
         kP1LJrip1qODqQFEzM9mOt8XC/FLgqtH/vE6l+QvmQTqHWwImuuZvmyePox2rvqlXd
         gZT948G5E5O4WXrrsc8vVuURn4wruSLy/Gr6M6HRrExPcUuxhGg6Cz/3ke9s7UxFuP
         mH0XU5N/3sbkA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D78BA4035A; Fri, 12 Aug 2022 15:53:16 -0300 (-03)
Date:   Fri, 12 Aug 2022 15:53:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 00/14] perf: test: Add trace data quality tests for
 CoreSight
Message-ID: <YvahnOSyts95F8xm@kernel.org>
References: <20220812121641.336465-1-carsten.haitzler@foss.arm.com>
 <YvahJcUNAZ0WC8fj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvahJcUNAZ0WC8fj@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 12, 2022 at 03:51:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Aug 12, 2022 at 01:16:27PM +0100, carsten.haitzler@foss.arm.com escreveu:
> > previous older versions of test scripts that are editor backup files
> > as well as skipping perf.data files that may appear and so on.

> > Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

> On the next series, please add to the cover letter a summary of what
> changed on each repost.

I also saw that several of your patches got reviewed and given
"Reviewed-by" tags, so if some of the patches in the previous versions
didn't change and received Reviewed-by tags, please collect them on the
current version.

- Arnaldo
