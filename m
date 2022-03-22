Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B784E4E3E59
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbiCVMVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiCVMVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:21:30 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F536A431;
        Tue, 22 Mar 2022 05:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=6qIQp2xm6EuHjSYSn5zUvpLG4+WO9mWTymWkDNlKecE=; b=qJ8nGmytOm23AMHEEUHxWwdSFc
        A+OAHuSE5Upeo9IlQdILvDU+AP4RTpTdasT8vePcGNZz8cilY38Ccf/kZ9OenWd3WXdI+pXrSVQKF
        B7mxby8ezuJzFIL3k8lIC7r6EwP7a1OnGuvPe9s1DIiahMVkaUTRbElo1JIcTK8olzxs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nWdUT-00C7U1-Gr; Tue, 22 Mar 2022 13:19:57 +0100
Date:   Tue, 22 Mar 2022 13:19:57 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pali@kernel.org, marek.behun@nic.cz
Subject: Re: [PATCH v2 2/2] arm64: dts: uDPU: correct temperature sensors
Message-ID: <Yjm+7ZRqqySXSJ+k@lunn.ch>
References: <20220322105857.1107016-1-robert.marko@sartura.hr>
 <20220322105857.1107016-2-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322105857.1107016-2-robert.marko@sartura.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:58:57AM +0100, Robert Marko wrote:
> uDPU has a pair of NCT375 temperature sensors, which are TMP75C compatible
> as far as the driver is concerned.
> 
> The current LM75 compatible worked as all of the LM75 compatible sensors
> are backwards compatible with the original part, but it meant that lower
> resolution and incorrect sample rate was being used.
> 
> The "lm75" compatible has been deprecated anyway and is meant as fallback
> in order to keep older DTS-es working.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
