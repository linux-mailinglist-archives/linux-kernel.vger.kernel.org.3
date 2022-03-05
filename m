Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928114CE6FC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiCEU3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiCEU3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:29:10 -0500
Received: from biche.re (biche.re [IPv6:2607:5300:201:3100::6c88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AB52AC4
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 12:28:18 -0800 (PST)
Date:   Sat, 5 Mar 2022 21:28:12 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 biche.re 3235D3EA7D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=biche.re; s=biche;
        t=1646512096; bh=qt2OQlf2eNHyy4Rr7O8K2qYNm+v84dIqyVBhQttppkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sHzJ/P/+ondZ6zrgu/ih8majvJrkWFbHU+5fPF1SMEG//SbeYiwMA//eq2pEUWHRI
         XPSxuy5a2db+TU/XJK4a2ERbMeDZmPqp3+58IDP0UoOu1nCh/xAQlh4PwICAMLioQg
         IdAercP++nNtRWmn+IK5+au1T0CXU9PgPc85PLQzourABv8iirKvvM33ii7oOCdsqE
         TbSR68QXJoJjJwUIGv2enSYEaPkO2by1Wslsig0IJTp7A9tFIEjAjkYZYMQRI6iZEa
         czH8heCEGJeka0zRjaoS0Ud3cH3uRrafqPOWRgbsobrcojyWsCLsbxdHTt5YIC2JEz
         RFxkE2hnr0IIA==
From:   Victorien Molle <biche@biche.re>
To:     linux-kernel@vger.kernel.org
Cc:     Victorien Molle <biche@biche.re>
Subject: Re: [PATCH] KVM: x86: Add support for basic RAPL (Running Average
 Power Limit) metrics
Message-ID: <YiPH3KFa6ZwsaZ77@ultrahax>
References: <20220109182317.1075762-1-biche@biche.re>
 <YfKCLAdwh0LZXIDz@ultrahax>
 <YgggGG92eMCzdomb@ultrahax>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgggGG92eMCzdomb@ultrahax>
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,
        SCC_BODY_URI_ONLY,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping https://lore.kernel.org/all/20220109182317.1075762-1-biche@biche.re/T/#u
