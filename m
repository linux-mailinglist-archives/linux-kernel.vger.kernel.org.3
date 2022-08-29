Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF435A556C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiH2UPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiH2UP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:15:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EF052E4D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E2176104F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 20:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066ACC433C1;
        Mon, 29 Aug 2022 20:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661804126;
        bh=Nbea/MpIsOS17vINEQkh4l2v2+uDWkJzDxG0xnh2o5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/4hV7AWRTtHbNO2ydnNUYecEgv9FmaqLVdaWEoK7MgoD8HiwI8djou27rIzJWCJO
         YzDBJmkCc50zWJktltsKhtFszG1L8EZzq8wWAhHZ2QSFyG0Q7GbJBUpwcxxdvpakeJ
         qcJttQ11Iwvhc44cpKzVA5pZExQSOxZtrTMWsm5iDdTh2xQizEwqth32AqpBxhjhqZ
         EKrs3COkiK15uhGUkSlZCb1nwregQFDBQDX3Z6cBp69q3jhqx4Zar98kslvNxkGOMK
         sbEU7/T9RzJ2ylxaCAsWMdbN4UuoU7CXRs9w3Lprh+2FNeLNuMR7xmmdjvKI7lxJbT
         YTLovUp7vNtMw==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-damon@amazon.com,
        linux-damon-trial@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date:   Mon, 29 Aug 2022 20:15:24 +0000
Message-Id: <20220829201524.52009-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810225102.124459-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,


On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> In short, I'd like to start an open, regular, and informal virtual bi-weekly
> meeting series for DAMON community.
> 
> Important links and dates
> -------------------------
> 
> Location: https://meet.google.com/ndx-evoc-gbu
> Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing
> 
> First instance: 2022-08-15 18:00 PDT
> Second instance: 2022-08-30 09:00 PDT

I just wanted to remind you the second instance of this chat series that
mentioned above will happen tomorrow morning (PDT).

Looking forward to see you there!


Thanks,
SJ

[...]
