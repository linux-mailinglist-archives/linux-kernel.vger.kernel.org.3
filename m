Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FF856332F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbiGAMJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiGAMJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:09:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EA451FCE5;
        Fri,  1 Jul 2022 05:08:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87B25113E;
        Fri,  1 Jul 2022 05:08:59 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.71.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 105CB3F792;
        Fri,  1 Jul 2022 05:08:57 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Patch series to add to and imporve tests for CoreSight
Date:   Fri,  1 Jul 2022 13:07:49 +0100
Message-Id: <20220701120804.3226396-1-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
Reply-To: carsten.haitzler@foss.arm.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This improves how perf test handles finding shell scripts to run as
part of the testing allowing sub-directories, skipping files that
are not intentional shell script tests and then adds a set of tests
that improve what we cover for Arm CoreSight testing. The goal of
these tests is to expand the scenarios and data traced and examined
to track quality of trace data and improvements to that over time.

Eventually it'd be neater to break up the current Arm CoreSight tests
into smaller focused tests that share the same infrastructure, but
this here would be a first step.


