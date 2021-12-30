Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9344819F6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 07:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbhL3GgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 01:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhL3GgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 01:36:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE0CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 22:36:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6CE1B819C4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 06:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0CFC36AE7;
        Thu, 30 Dec 2021 06:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640846171;
        bh=9QOHvBuZEzzxfHF5D63r+Ymjp5/qBkI1gadU29wm2fo=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=bNsPh5ruh2OE2RFfmT5STNFqnSZGzSU2qeTn1BCuYnU4Tko99M4t5xTHKOePXHttY
         gE3UiyL8dD1XNUU1lmvI6Ni8NJsKWE6TW/tz54rSDfq6YXRAp4RKqTCXkkycnf7oAY
         akN9D5eX5B0J1bsuQbXLuC+ZYftZRVLXIDiSeWQ08T/v6yO45bTQzKm8/9mngrL/cV
         C6RYpV/+ePvD9mjbpjnxZDGd2vZqHfjB7xl3jZ/ryKOIfOM5S+oHx1g79k4QPRKqAr
         8MstY3M2aUOj81VKd9At7swfT01s+5yOn6U5IzRqLNpzty7K1JTdxxH3CnUcVkmiXr
         w9odNYcQvhwbg==
Message-ID: <dc36ef4d-a66c-d02f-e54a-844b95acedde@kernel.org>
Date:   Thu, 30 Dec 2021 14:36:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: avoid down_write on nat_tree_lock
 during checkpoint
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20211214182435.2595176-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211214182435.2595176-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/15 2:24, Jaegeuk Kim wrote:
> Let's cache nat entry if there's no lock contention only.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
