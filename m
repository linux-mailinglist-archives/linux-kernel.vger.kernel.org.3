Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F376247E3F9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243585AbhLWNPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:15:05 -0500
Received: from ciao.gmane.io ([116.202.254.214]:46868 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236068AbhLWNPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:15:03 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1n0Nvx-000ANQ-VX
        for linux-kernel@vger.kernel.org; Thu, 23 Dec 2021 14:15:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Sergey Organov <sorganov@gmail.com>
Subject: Selecting MMU page size for an architecture 
Date:   Thu, 23 Dec 2021 01:34:45 +0300
Message-ID: <sq0965$aed$1@ciao.gmane.io>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We are building custom CPU and have an option to choose either 4K or 16K
MMU minimum page size that will then be fixed in the hardware. For
reasons unrelated to the Linux kernel we'd prefer 16K, but I have some
doubts.

What pros and cons for kernel and user-space operation 16K pages will
have over more usual 4K pages? Anything we should worry about?

Thanks,
-- Sergey Organov

