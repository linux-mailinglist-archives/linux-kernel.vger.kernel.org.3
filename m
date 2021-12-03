Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6973F467A54
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381800AbhLCPgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:36:08 -0500
Received: from confino.investici.org ([212.103.72.250]:54175 "EHLO
        confino.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381772AbhLCPgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:36:07 -0500
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Dec 2021 10:36:07 EST
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4J5Gm95sfDz112Q
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 15:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autistici.org;
        s=stigmate; t=1638544969;
        bh=podjhW9v95oShPlvSvm7Zi70Q93AnLNUUOOjotS+h4A=;
        h=From:To:Subject:Date:From;
        b=Xb9rGlS9Eym9RkezFsfNjYf9TGtXP/ysDWGgzasBTJMx49BpVmSVZzucsnJyjzJxs
         yglOcstZITq04yV2891zqUYOBTCgeoEFzIi6fg7DjlRcJhQannK/2FNeWKpOPWpDlJ
         BiEMquypng7/A9ySugSbTbhoNUhZl69M2meXPmnI=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: andrea.monaco@autistici.org) by localhost (Postfix) with ESMTPSA id 4J5Gm953Tnz112M
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 15:22:49 +0000 (UTC)
From:   Andrea Monaco <andrea.monaco@autistici.org>
To:     linux-kernel@vger.kernel.org
Subject: 4.19.132: ENOENT is misleading when attempting exec of foreign
 executable
Date:   Fri, 03 Dec 2021 16:22:48 +0100
Message-ID: <87a6hhlnlj.fsf@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello.


When I try to execl an ELF executable from another system I get an
ENOENT.  Maybe the reason is an interpreter not found, but I think that
error is still misleading, because the executable is obviously there.
Perhaps one of EINVAL or ENOEXIST is more fitting.



Warmly,
-- 
Andrea G. Monaco
Lgbt+ activist, hacker, mathematician
"Hope will never be silent!", H. Milk
