Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F654A923A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 03:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356611AbiBDCKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 21:10:41 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:54366 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232218AbiBDCKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 21:10:39 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 4 Feb 2022 11:10:37 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.31.96)
        by 156.147.1.126 with ESMTP; 4 Feb 2022 11:10:37 +0900
X-Original-SENDERIP: 10.178.31.96
X-Original-MAILFROM: chanho.min@lge.com
From:   Chanho Min <chanho.min@lge.com>
To:     krzysztof.kozlowski@canonical.com
Cc:     chanho.min@lge.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, gunho.lee@lge.com
Subject: Re: [PATCH 2/2] arm64: dts: lg: align pl330 node name with dtschema
Date:   Fri,  4 Feb 2022 11:10:37 +0900
Message-Id: <20220204021037.44331-1-chanho.min@lge.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220129175514.298942-2-krzysztof.kozlowski@canonical.com>
References: <20220129175514.298942-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fixes dtbs_check warnings like:

>  dma@c1128000: $nodename:0: 'dma@c1128000' does not match '^dma-controller(@.*)?$'

Acked-by: Chanho Min <chanho.min@lge.com>
