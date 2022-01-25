Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B528E49B0FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiAYJy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbiAYJwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:52:15 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA20C06176C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 01:52:15 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id b37so18628717uad.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 01:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qR5YJcLW2GI0pCEyIs9uAaekT483+eeoDNQCmnpeWL0=;
        b=oBz6bkmpMKQDFtjXTSMZMGJwW4VzyQrF+9lg0ezZlkiheqPmGAyxsv1rcXZsmJ/teU
         9rjT4qeeZKcW0z6/nlXrH1WjzSoldzf91e10GAgSe03uuyHAbSny42LNQVcPy1jtJHYB
         gBbnLdXqNMOn6lVolju1wGy3+GjrgpVGWwabCxbzW815wpsL7OA2NDwTB5ZtOdHBv5cc
         EFxDPah7IUJsVPioo3prDv8cH3Tc7atS/+2bx9btVzld4WdF8YWdA+njbhJ3IIRBuX5Z
         Wj7GWaLhx/feClQaAv27SUwh3tZZJnFHCbTGQWn8odio9A86Hy9Y4EITdGQQEr27jNbz
         FQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=qR5YJcLW2GI0pCEyIs9uAaekT483+eeoDNQCmnpeWL0=;
        b=CT2ZxINKUuOkfzBDVow0AFaVgwEHCG4BQMfjSzjkOKKsson4aVVO8R24ZCMnECrKnQ
         FgwLGeP2AVPhRj0Wkbe+LpKXD9aOc/7UvzBXlsnJxBeAlO5ZZYaCdAOUFolrSiEpyOHx
         1EPBjOZ7oIdiTcMTg42uipg6ZZNLA7mVMWXMoFHAUjWYSURHtaEzFjjHH0FvN9WUTEYh
         P0MhexkRkk4FAwpfapuaGvc3AXzHUEMmziM0pZ6bXY+irHk58oGr1VaSav838cwfUEnC
         /sW1+kTGy7MWOCzwRQ1RcRc+VbAUNmFlnVASY5df9jwOh+E2Gp2O0Gs/eIkhwOEH23+D
         qINQ==
X-Gm-Message-State: AOAM530q0JBlTVVTFpOKm1GtUYu6zFheKgUeSBut1oeNtRciqUhC+TxY
        S5DhQmijKXrHz6uk64/iGzTtqqUwBiuNvBcvAmE=
X-Google-Smtp-Source: ABdhPJw1kee37xDnHxsvIxx/V2KHgXmL9VIO4H25+PcVbS9btHnWwXL66vZ+DGAfWLmHFKf6fGSBMi8FkaReeQEP29E=
X-Received: by 2002:a67:c093:: with SMTP id x19mr5350370vsi.20.1643104334444;
 Tue, 25 Jan 2022 01:52:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:612c:2109:b0:275:d70f:63a3 with HTTP; Tue, 25 Jan 2022
 01:52:13 -0800 (PST)
Reply-To: sgtmanthey10@gmail.com
From:   kayla manthey <93531103abala@gmail.com>
Date:   Tue, 25 Jan 2022 09:52:13 +0000
Message-ID: <CAGEfFFcv-POSyP1Y3BwFYumTGUiuE04yhiBDvDTa-Z32SoasdQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Bitte, ich m=C3=B6chte wissen, ob Sie meine vorherigen Nachrichten erhalten=
 haben.
