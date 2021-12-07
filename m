Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832C146B492
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhLGHzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:55:33 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:56991 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230360AbhLGHzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:55:32 -0500
Received: from [192.168.0.3] (ip5f5aea86.dynamic.kabel-deutschland.de [95.90.234.134])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id B070C61E6478B;
        Tue,  7 Dec 2021 08:52:00 +0100 (CET)
Message-ID: <0ba14395-7c35-025a-d904-fddf5dd1e0bb@molgen.mpg.de>
Date:   Tue, 7 Dec 2021 08:52:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Check that no dot/period ends the commit message summary?
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear checkpatch folks,


git’s default messages don’t use a dot/period at the end of the commit 
message summary (title).

•   Revert …
•   Merge …

Some guides on the WWW, like *How to Write a Git Commit Message* [1], 
also recommend that: Do not end the subject line with a period.

Would that be sensible to add to the checkpatch script?


Kind regards,

Paul


[1]: https://cbea.ms/git-commit/#end
