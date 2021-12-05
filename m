Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5854688FF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 04:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhLEDsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 22:48:00 -0500
Received: from mail1.bemta31.messagelabs.com ([67.219.246.112]:35000 "EHLO
        mail1.bemta31.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229682AbhLEDr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 22:47:59 -0500
Received: from [100.114.1.131] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.us-east-1.aws.ess.symcld.net id 01/6F-01499-6853CA16; Sun, 05 Dec 2021 03:44:06 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTfVRTZRzmvfduuyGDsdnhRnqMlXEiN5lQvMj
  hHLFz8tqpo57w9HHUuMRgqzFodxQSJdGRlEAI42PAgEBNBiQgOCAhWXyrcBhgq6ESqExkO+Mj
  lEXQHX5E/zznOc/ze5/f88fvxVF+CscblyaqpSolpRCyXbHQ+WfPiNJeqab8b2cK4KhuBoHpv
  9wBcFxjxeBw2SUMNkxrEFg5fwqFP+lvcmBuXSaAg393MlrOrxxY3FXLhm1XrAicSR8HsEBjA3
  DiayMGs1eYt3ZzEQLztAMYvGVWwUnzeQSmDBxH4bxtCIFt2kYU2i/3YvCHtj4M9k73cGDWb0c
  BHGopZsOxjHYWNJnzWPBqcRYHTucRcPRBLgrvjFQisFZjBHCu6hoGU2sNKKxsZypWNeVzYFuu
  A4VljY0suHS8AIHlNXoAj10+Aie+/RmFhpP1CBxPH0RhzrANhX8Y73Pg3PgUZ8c28ua9OhZpy
  7WjZNODcDJ7wsImDa1vkJbJXkAO5J8GZE2nhkPqz9xAyGWHDiH/MVg55Ei6DiPTGoYx0rIgIb
  tPBJIr+ovIXt/3WXJlZFxiBEt2dvoKK34JJPbndiIpYASkA1ecz6sBhO2rTFY6eArHeC8TFd8
  NcZyczQslUvOvMjrODD1PmMZinLKAxydMl2ZQJ+fygghtR+cqR3m+xFKJ8RHfROitxY9mPIle
  zS3MyQnec8S1+QLWQ/4qYcnRrK5az9tAaIsmWNnArXBNVOGaqMI1UWUA1YHgSJU8RqaOpeQKk
  cTfXySRBIoCRUH+YipJRIkTaJGUotUiiZj6jBZLaVpMH479UBElVkrV9YA5tCgV9noT0GUsig
  3gGRwRPs1dGa2i+O6RcVGHZRQt+0CVoJDSBrABx4UEN2RbNcX3VEljpInRcgVzro9tAncTrue
  ekzA2l46nYml5zEOrD+zDU+9qy1G8rrOEQf0qdq3ibd0pBu82O9HqRD6mjFNKvb24ugAmiOcM
  kiUon6x5/DGMYKO3gAtcXFz4bvFSVaxc/X9/CnjhQCjgmpwpbnKl+kmbKaYowhQ9kFXlLKqm/
  rO8U5Bmf9XkO7w/M312LHO9fMCLk7szKs4vn+jRfbk4xBtM+1hb5rXFtKD3c0iC2odLNXOs6k
  NJByorEt23Wlm7euzeEXvQvy7sWfBdaXmtf9g17C2Pg4qewLGIj7bXfho/vrG27X7D6SnzJ+1
  m/rqLfnme3+wXZ54tKe3e2nfP7Hqj492QaCLgpZ2yKrpSNDT7va/l80pNW6jYUV5td+mI2HXo
  i4MhLbM/tk75uNX/HgAXIx3V+xweNWFJu8Ovu1s27zWdDF4StAr2H+tPPhrSscVYynW1NCR3T
  6/z2TybEnxhp9dglcb2nvq6b/MRdswLyXVvd1iDu7aP2vNDosvPFXm8mRC+KUyI0TJK4oeqaO
  pfBQ6zNpMEAAA=
X-Env-Sender: chew_lh@biomesciltlight.com
X-Msg-Ref: server-5.tower-706.messagelabs.com!1638675845!101037!1
X-Originating-IP: [61.244.27.166]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=biomesciltlight.com,-,-
X-VirusChecked: Checked
Received: (qmail 15290 invoked from network); 5 Dec 2021 03:44:06 -0000
Received: from mail.merkur-ltd.com (HELO mail.merkur-ltd.com) (61.244.27.166)
  by server-5.tower-706.messagelabs.com with SMTP; 5 Dec 2021 03:44:06 -0000
Received: from mail.merkur-ltd.com (mail.merkur-ltd.com [61.244.27.166])
        by mail.merkur-ltd.com (Postfix) with ESMTP id AC861134CEC7;
        Sun,  5 Dec 2021 11:43:56 +0800 (HKT)
Date:   Sun, 05 Dec 2021 11:43:56 +0800 (HKT)
From:   World Health Organization <chew_lh@biomesciltlight.com>
Reply-To: attorneyvicrayk@gmail.com
Subject: Good News
Message-ID: <84d2be7f-b66e-43c5-bbea-b06e18b5b999@mail>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [102.89.3.181]
X-Mailer: Zimbra 7.1.0_GA_3140 (zclient/7.1.0_GA_3140)
To:     undisclosed-recipients:;
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



The World Health Organization has listed you among the 10 people to receive a corona relief fund of $500,000.00 USD. Send your full details
 including your mobile number through the email address below: attorneyvicrayk@gmail.com  for more information.

______________________________________________________________________
This email has been scanned by the Symantec Email Security.cloud service.
For more information please visit http://www.symanteccloud.com
______________________________________________________________________
