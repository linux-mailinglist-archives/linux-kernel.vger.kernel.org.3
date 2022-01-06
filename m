Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE584864AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 13:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbiAFM6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 07:58:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59204 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiAFM6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:58:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4BDC61AD2;
        Thu,  6 Jan 2022 12:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218CFC36AE3;
        Thu,  6 Jan 2022 12:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641473925;
        bh=pFQQorRYR0jKc38c0tyfpxDF7T3minJsepqpjPbejBI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Y4XHnxMBknaUIqGSGdefv04t8xJw8LFdOcmj2teC+Z8o2LECzrRCZgoV28LrWo/sG
         sdq4hgr6Oa4n8MddSJIg1XCIJErttVmnWx2+WfuunQMxag/U5c8AOOOqAY/M5I5fCD
         QsgmucowmUhk0e6HEV7YxjxiL9EBQZxRFpO1lWBDdTNtySZDouU4GQKMHnYUPOnLWq
         YoP70X108itJFYdz4hOxiQ9gbXppNRhgtyoKskfuYGhLbPWp6pUzbijzwIWYQyIEfs
         cH2wAvNurGmiP+NmgejZIphtw3sBd+EuQlk06pMtAWXhdA2vrSvhkZ5IMOtjjMVc36
         ZpTmvjjiVGjWg==
Date:   Thu, 6 Jan 2022 13:58:42 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add Apple Magic Trackpad 2021 support
In-Reply-To: <20211212182100.40968-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2201061358350.16505@cbobk.fhfr.pm>
References: <20211212182100.40968-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2021, José Expósito wrote:

> The Apple Magic Trackpad 2021 (3rd generation) is almost identical
> to the 2nd generation devices.
> 
> The only meaningful change from the driver point of view is that
> its name has changed.
> 
> This small series adds support for the device and solves a bug
> caused when the default name of the device has been personalized.

Applied, thanks José.

-- 
Jiri Kosina
SUSE Labs

