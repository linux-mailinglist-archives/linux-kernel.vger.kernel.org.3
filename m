Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2F55642D5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 23:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiGBVJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 17:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGBVJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 17:09:01 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9848CCE11;
        Sat,  2 Jul 2022 14:08:55 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id B94B3BDA;
        Sat,  2 Jul 2022 23:08:53 +0200 (CEST)
Authentication-Results: ext-mx-out001.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1656796130; x=1658610531;
         bh=GnikFpiIlPqqoO7Rn7vOUrnoMo5l69T2naZxp4R6TgI=; b=guW2Yu2VKEXG
        waU3Gv9oLkpfcNDkFudepCnPxHW6p1x7Q/lANxZYWxQRcP0gECZ4tii1V6YJktUQ
        FVGDk658VookI/gDzofttuEcEAe3tfd5da6Tc81kt+WThgHYdtOz0KPbTHurKWot
        67HLCPhCKhr66FL+IvNY8RBIQCEfF6GFuu1OjhgWJsJ2EvqNuYO6fRYwYn7/ayZ5
        TwkS/Xg56nylUXHcJkQhmtOwE8WPR2Ny0TeycJK1v4e+KAnPjIgvtEip08jI2App
        kQYTXWnxBTlq1twDSN1bFukXXdiUo/s7CSRgDITXioMeEt2sQhWGdhv1Xa6tIXcT
        ATs2sDxkaycwQC4KFZu06MDhjMXLjiHw558+LNv3bgk4iLNrSTdfmcgb8g1c9VYL
        NxLi8OH99KTtziHEXkn2SquSpSec8ZDAV1rOuSBy2ojCXtnRTihgdOCn2W0r16Uv
        nv05me8j0P6MTg8dkM/W/LzdDmBgtLulF971Yx94EMLKOgSdssiVn6Sb44LoEduY
        SJayQ9FbY+aW8DvVJ1LIMAMIoVhXbcBRVax0HgoXrXB9PFsMDYB/BGvFqeecp+/T
        uvC8MOKUHxXyCTo1ZxQDsLXGZhE4jKnB0qbZbhWVAUNkyXmNbUv+0/M3DQ2Y7yYc
        BayEAWqmzGfrEZBmUCCQwT6l6I7Sulc=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kutidCKHTo3Z; Sat,  2 Jul 2022 23:08:50 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by mx.kolabnow.com (Postfix) with ESMTPS id D947FA05;
        Sat,  2 Jul 2022 23:08:48 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 874D844D8;
        Sat,  2 Jul 2022 23:08:48 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH v2] doc:it_IT: align Italian documentation
Date:   Sat,  2 Jul 2022 23:08:20 +0200
Message-Id: <20220702210820.13118-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translation for the following patches

commit df05c0e9496c ("Documentation: Raise the minimum supported version of LLVM to 11.0.0")
commit 333b11e541fe ("Documentation: Add minimum pahole version")
commit 6d6a8d6a4ed0 ("docs: Update Sphinx requirements")
commit 76ae847497bc ("Documentation: raise minimum supported version of GCC to 5.1")
commit 59c6a716b14b ("Documentation/process/maintainer-pgp-guide: Replace broken link to PGP path finder")
commit 85eafc63d032 ("docs: update file link location")
commit 869f496e1aa6 ("docs: process: submitting-patches: Clarify the Reported-by usage")
commit 6c5ccd24ff17 ("Remove mentions of the Trivial Patch Monkey")
commit aa9b5e0df226 ("Documentation/process: fix self reference")
commit b96ff02ab2be ("Documentation/process: fix a cross reference")
commit 1f57bd42b77c ("docs: submitting-patches: make section about the Link: tag more explicit")
commit a9d85efb25fb ("docs: use the lore redirector everywhere")
commit 31c9d7c82975 ("Documentation/process: Add tip tree handbook")
commit 604370e106cc ("Documentation/process: Add maintainer handbooks section")
commit bf33a9d42d0c ("docs: 5.Posting.rst: describe Fixes: and Link: tags")
commit c04639a7d2fb ("coding-style.rst: trivial: fix location of driver model macros")
commit d5b421fe0282 ("docs: Explain the desired position of function attributes")
commit 3577cdb23b8f ("docs: deprecated.rst: Clarify open-coded arithmetic with literals")
commit db67eb748e7a ("docs: discourage use of list tables")
commit 0e805b118662 ("docs: address some text issues with css/theme support")
commit 135707d3765e ("docs: allow to pass extra DOCS_CSS themes via make")
commit fe450eeb4e6f ("Documentation: in_irq() cleanup")
commit 10855b45a428 ("docs: fix typo in Documentation/kernel-hacking/locking.rst")
commit bc67f1c454fb ("docs: futex: Fix kernel-doc references")
commit abf36fe0be7d ("docs: kernel-hacking: Remove inappropriate text")
commit f35cf1a59e9a ("Documentation: kernel-hacking: minor edits for style")
commit f35cf1a59e9a ("Documentation: kernel-hacking: minor edits for style")
commit 980c3799c500 ("Documentation: kernel-doc: Promote two chapter headings to page title")
commit e1be43d9b5d0 ("overflow: Implement size_t saturating arithmetic helpers")
commit 615f3eea0d5f ("Documentation: add note block surrounding security patch note")
commit 587d39b260c4 ("Documentation: add link to stable release candidate tree")
commit 555d44932c67 ("Documentation: update stable tree link")
commit 88d99e870143 ("Documentation: update stable review cycle documentation")
commit 0c603a5c704f ("Documentation/process: mention patch changelog in review process")
commit 6d5aa418b3bd ("docs: submitting-patches: Fix crossref to 'The canonical patch format'")
commit f1a693994b1c ("Documentation/process: use scripts/get_maintainer.pl on patches")
commit 69ef0920bdd3 ("Docs: Add cpio requirement to changes.rst")
commit 5a5866c28b43 ("Docs: Replace version by 'current' in changes.rst")
commit 9b5a7f4a2a8d ("x86/configs: Add x86 debugging Kconfig fragment plus docs")
commit f1a693994b1c ("Documentation/process: use scripts/get_maintainer.pl on patches")
commit e8c07082a810 ("Kbuild: move to -std=gnu11")

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---

v1 -> v2
Fix wornings about duplicated use of `maintainers-include`


 .../bindings/submitting-patches.rst           | 11 +++
 .../it_IT/doc-guide/kernel-doc.rst            |  2 +
 .../translations/it_IT/doc-guide/sphinx.rst   | 18 +++--
 .../it_IT/kernel-hacking/hacking.rst          | 24 +++----
 .../it_IT/kernel-hacking/locking.rst          | 14 +---
 .../it_IT/maintainer/configure-git.rst        | 10 +++
 .../it_IT/process/3.Early-stage.rst           | 17 ++---
 .../translations/it_IT/process/5.Posting.rst  | 27 ++++++--
 .../translations/it_IT/process/changes.rst    | 25 +++++--
 .../it_IT/process/coding-style.rst            | 42 +++++++++++-
 .../translations/it_IT/process/deprecated.rst | 24 +++++--
 .../translations/it_IT/process/index.rst      |  1 +
 .../it_IT/process/maintainer-handbooks.rst    | 24 +++++++
 .../it_IT/process/maintainer-pgp-guide.rst    | 14 ++--
 .../it_IT/process/maintainer-tip.rst          | 10 +++
 .../it_IT/process/maintainers.rst             | 13 ++++
 .../it_IT/process/stable-kernel-rules.rst     | 42 +++++++++---
 .../it_IT/process/submitting-patches.rst      | 68 +++++++++++++------
 18 files changed, 289 insertions(+), 97 deletions(-)
 create mode 100644 Documentation/translations/it_IT/devicetree/bindings/submitting-patches.rst
 create mode 100644 Documentation/translations/it_IT/maintainer/configure-git.rst
 create mode 100644 Documentation/translations/it_IT/process/maintainer-handbooks.rst
 create mode 100644 Documentation/translations/it_IT/process/maintainer-tip.rst
 create mode 100644 Documentation/translations/it_IT/process/maintainers.rst

diff --git a/Documentation/translations/it_IT/devicetree/bindings/submitting-patches.rst b/Documentation/translations/it_IT/devicetree/bindings/submitting-patches.rst
new file mode 100644
index 000000000000..b473cd2190be
--- /dev/null
+++ b/Documentation/translations/it_IT/devicetree/bindings/submitting-patches.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../../disclaimer-ita.rst
+
+:Original: Documentation/devicetree/bindings/submitting-patches.rst
+
+================================================
+Sottomettere patch per devicetree (DT) *binding*
+================================================
+
+.. note:: to be translated
diff --git a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
index 009cdac014b6..78082281acf9 100644
--- a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
+++ b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
@@ -5,6 +5,7 @@
 
 .. _it_kernel_doc:
 
+=================================
 Scrivere i commenti in kernel-doc
 =================================
 
@@ -469,6 +470,7 @@ Il titolo che segue ``DOC:`` funziona da intestazione all'interno del file
 sorgente, ma anche come identificatore per l'estrazione di questi commenti di
 documentazione. Quindi, il titolo dev'essere unico all'interno del file.
 
+=======================================
 Includere i commenti di tipo kernel-doc
 =======================================
 
diff --git a/Documentation/translations/it_IT/doc-guide/sphinx.rst b/Documentation/translations/it_IT/doc-guide/sphinx.rst
index 9762452c584c..64528790dc34 100644
--- a/Documentation/translations/it_IT/doc-guide/sphinx.rst
+++ b/Documentation/translations/it_IT/doc-guide/sphinx.rst
@@ -5,8 +5,9 @@
 
 .. _it_sphinxdoc:
 
-Introduzione
-============
+=============================================
+Usare Sphinx per la documentazione del kernel
+=============================================
 
 Il kernel Linux usa `Sphinx`_ per la generazione della documentazione a partire
 dai file `reStructuredText`_ che si trovano nella cartella ``Documentation``.
@@ -158,6 +159,9 @@ Per poter passare ulteriori opzioni a Sphinx potete utilizzare la variabile
 make ``SPHINXOPTS``. Per esempio, se volete che Sphinx sia più verboso durante
 la generazione potete usare il seguente comando ``make SPHINXOPTS=-v htmldocs``.
 
+Potete anche personalizzare l'ouptut html passando un livello aggiuntivo
+DOCS_CSS usando la rispettiva variabile d'ambiente ``DOCS_CSS``.
+
 Potete eliminare la documentazione generata tramite il comando
 ``make cleandocs``.
 
@@ -276,11 +280,11 @@ incrociato quando questa ha una voce nell'indice.  Se trovate degli usi di
 Tabelle a liste
 ---------------
 
-Raccomandiamo l'uso delle tabelle in formato lista (*list table*). Le tabelle
-in formato lista sono liste di liste. In confronto all'ASCII-art potrebbero
-non apparire di facile lettura nei file in formato testo. Il loro vantaggio è
-che sono facili da creare o modificare e che la differenza di una modifica è
-molto più significativa perché limitata alle modifiche del contenuto.
+Il formato ``list-table`` può essere utile per tutte quelle tabelle che non
+possono essere facilmente scritte usando il formato ASCII-art di Sphinx. Però,
+questo genere di tabelle sono illeggibili per chi legge direttamente i file di
+testo. Dunque, questo formato dovrebbe essere evitato senza forti argomenti che
+ne giustifichino l'uso.
 
 La ``flat-table`` è anch'essa una lista di liste simile alle ``list-table``
 ma con delle funzionalità aggiuntive:
diff --git a/Documentation/translations/it_IT/kernel-hacking/hacking.rst b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
index d5c521327f6a..9fd5327ca728 100644
--- a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
@@ -129,8 +129,7 @@ eseguiti simultaneamente.
 .. warning::
 
     Il nome 'tasklet' è ingannevole: non hanno niente a che fare
-    con i 'processi' ('tasks'), e probabilmente hanno più a che vedere
-    con qualche pessima vodka che Alexey Kuznetsov si fece a quel tempo.
+    con i 'processi' ('tasks').
 
 Potete determinate se siete in un softirq (o tasklet) utilizzando la
 macro :c:func:`in_softirq()` (``include/linux/preempt.h``).
@@ -308,7 +307,7 @@ esse copiano una quantità arbitraria di dati da e verso lo spazio utente.
     Al contrario di:c:func:`put_user()` e :c:func:`get_user()`, queste
     funzioni ritornano la quantità di dati copiati (0 è comunque un successo).
 
-[Sì, questa stupida interfaccia mi imbarazza. La battaglia torna in auge anno
+[Sì, questa interfaccia mi imbarazza. La battaglia torna in auge anno
 dopo anno. --RR]
 
 Le funzioni potrebbero dormire implicitamente. Queste non dovrebbero mai essere
@@ -679,9 +678,8 @@ tutti sulle spine: questo riflette cambiamenti fondamentati (eg. la funzione
 non può più essere chiamata con le funzioni attive, o fa controlli aggiuntivi,
 o non fa più controlli che venivano fatti in precedenza). Solitamente a questo
 s'accompagna un'adeguata e completa nota sulla lista di discussone
-linux-kernel; cercate negli archivi.
-Solitamente eseguire una semplice sostituzione su tutto un file rendere
-le cose **peggiori**.
+più adatta; cercate negli archivi. Solitamente eseguire una semplice
+sostituzione su tutto un file rendere le cose **peggiori**.
 
 Inizializzazione dei campi d'una struttura
 ------------------------------------------
@@ -759,14 +757,14 @@ Mettere le vostre cose nel kernel
 Al fine d'avere le vostre cose in ordine per l'inclusione ufficiale, o
 anche per avere patch pulite, c'è del lavoro amministrativo da fare:
 
--  Trovare di chi è lo stagno in cui state pisciando. Guardare in cima
+-  Trovare chi è responsabile del codice che state modificando. Guardare in cima
    ai file sorgenti, all'interno del file ``MAINTAINERS``, ed alla fine
    di tutti nel file ``CREDITS``. Dovreste coordinarvi con queste persone
    per evitare di duplicare gli sforzi, o provare qualcosa che è già stato
    rigettato.
 
    Assicuratevi di mettere il vostro nome ed indirizzo email in cima a
-   tutti i file che create o che mangeggiate significativamente. Questo è
+   tutti i file che create o che maneggiate significativamente. Questo è
    il primo posto dove le persone guarderanno quando troveranno un baco,
    o quando **loro** vorranno fare una modifica.
 
@@ -787,12 +785,12 @@ anche per avere patch pulite, c'è del lavoro amministrativo da fare:
    "obj-$(CONFIG_xxx) += xxx.o". La sintassi è documentata nel file
    ``Documentation/kbuild/makefiles.rst``.
 
--  Aggiungete voi stessi in ``CREDITS`` se avete fatto qualcosa di notevole,
-   solitamente qualcosa che supera il singolo file (comunque il vostro nome
-   dovrebbe essere all'inizio dei file sorgenti). ``MAINTAINERS`` significa
+-  Aggiungete voi stessi in ``CREDITS`` se credete di aver fatto qualcosa di
+   notevole, solitamente qualcosa che supera il singolo file (comunque il vostro
+   nome dovrebbe essere all'inizio dei file sorgenti). ``MAINTAINERS`` significa
    che volete essere consultati quando vengono fatte delle modifiche ad un
-   sottosistema, e quando ci sono dei bachi; questo implica molto di più
-   di un semplice impegno su una parte del codice.
+   sottosistema, e quando ci sono dei bachi; questo implica molto di più di un
+   semplice impegno su una parte del codice.
 
 -  Infine, non dimenticatevi di leggere
    ``Documentation/process/submitting-patches.rst`` e possibilmente anche
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
index 163f1bd4e857..51af37f2d621 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -102,16 +102,11 @@ che non esistano.
 Sincronizzazione nel kernel Linux
 =================================
 
-Se posso darvi un suggerimento: non dormite mai con qualcuno più pazzo di
-voi. Ma se dovessi darvi un suggerimento sulla sincronizzazione:
-**mantenetela semplice**.
+Se dovessi darvi un suggerimento sulla sincronizzazione: **mantenetela
+semplice**.
 
 Siate riluttanti nell'introduzione di nuovi *lock*.
 
-Abbastanza strano, quest'ultimo è l'esatto opposto del mio suggerimento
-su quando **avete** dormito con qualcuno più pazzo di voi. E dovreste
-pensare a prendervi un cane bello grande.
-
 I due principali tipi di *lock* nel kernel: spinlock e mutex
 ------------------------------------------------------------
 
@@ -316,7 +311,7 @@ Pete Zaitcev ci offre il seguente riassunto:
 
 -  Se siete in un contesto utente (una qualsiasi chiamata di sistema)
    e volete sincronizzarvi con altri processi, usate i mutex. Potete trattenere
-   il mutex e dormire (``copy_from_user*(`` o ``kmalloc(x,GFP_KERNEL)``).
+   il mutex e dormire (``copy_from_user(`` o ``kmalloc(x,GFP_KERNEL)``).
 
 -  Altrimenti (== i dati possono essere manipolati da un'interruzione) usate
    spin_lock_irqsave() e spin_unlock_irqrestore().
@@ -979,9 +974,6 @@ fallisce nel trovare quello che vuole, quindi rilascia il *lock* di lettura,
 trattiene un *lock* di scrittura ed inserisce un oggetto; questo genere di
 codice presenta una corsa critica.
 
-Se non riuscite a capire il perché, per favore state alla larga dal mio
-codice.
-
 corsa fra temporizzatori: un passatempo del kernel
 --------------------------------------------------
 
diff --git a/Documentation/translations/it_IT/maintainer/configure-git.rst b/Documentation/translations/it_IT/maintainer/configure-git.rst
new file mode 100644
index 000000000000..8316fa53946f
--- /dev/null
+++ b/Documentation/translations/it_IT/maintainer/configure-git.rst
@@ -0,0 +1,10 @@
+.. include:: ../disclaimer-ita.rst
+
+:Original: Documentation/process/botching-up-ioctls.rst
+
+.. _it_configuregit:
+
+Configurare Git
+===============
+
+.. note::  To be translated
diff --git a/Documentation/translations/it_IT/process/3.Early-stage.rst b/Documentation/translations/it_IT/process/3.Early-stage.rst
index 443ac1e5558f..0809de39108a 100644
--- a/Documentation/translations/it_IT/process/3.Early-stage.rst
+++ b/Documentation/translations/it_IT/process/3.Early-stage.rst
@@ -168,14 +168,15 @@ in questa ricerca:
 
 	.../scripts/get_maintainer.pl
 
-Se questo script viene eseguito con l'opzione "-f" ritornerà il
-manutentore(i) attuale per un dato file o cartella.  Se viene passata una
-patch sulla linea di comando, lo script elencherà i manutentori che
-dovrebbero riceverne una copia.  Ci sono svariate opzioni che regolano
-quanto a fondo get_maintainer.pl debba cercare i manutentori;
-siate quindi prudenti nell'utilizzare le opzioni più aggressive poiché
-potreste finire per includere sviluppatori che non hanno un vero interesse
-per il codice che state modificando.
+Se questo script viene eseguito con l'opzione "-f" ritornerà il manutentore(i)
+attuale per un dato file o cartella. Se viene passata una patch sulla linea di
+comando, lo script elencherà i manutentori che dovrebbero riceverne una copia.
+Questo è la maniera raccomandata (non quella con "-f") per ottenere la lista di
+persone da aggiungere a Cc per le vostre patch. Ci sono svariate opzioni che
+regolano quanto a fondo get_maintainer.pl debba cercare i manutentori; siate
+quindi prudenti nell'utilizzare le opzioni più aggressive poiché potreste finire
+per includere sviluppatori che non hanno un vero interesse per il codice che
+state modificando.
 
 Se tutto ciò dovesse fallire, parlare con Andrew Morton potrebbe essere
 un modo efficace per capire chi è il manutentore di un dato pezzo di codice.
diff --git a/Documentation/translations/it_IT/process/5.Posting.rst b/Documentation/translations/it_IT/process/5.Posting.rst
index 1476d51eb5e5..d3ac555a6250 100644
--- a/Documentation/translations/it_IT/process/5.Posting.rst
+++ b/Documentation/translations/it_IT/process/5.Posting.rst
@@ -214,13 +214,28 @@ irrilevanti (quelli generati dal processo di generazione, per esempio, o i file
 di backup del vostro editor).  Il file "dontdiff" nella cartella Documentation
 potrà esservi d'aiuto su questo punto; passatelo a diff con l'opzione "-X".
 
-Le etichette sopra menzionante sono usate per descrivere come i vari
-sviluppatori sono stati associati allo sviluppo di una patch.  Sono descritte
-in dettaglio nel documento :ref:`translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`;
-quello che segue è un breve riassunto.  Ognuna di queste righe ha il seguente
-formato:
+Le etichette sopracitate danno un'idea di come una patch prende vita e sono
+descritte nel dettaglio nel documento
+:ref:`Documentation/translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`.
+Qui di seguito un breve riassunto.
 
-::
+Un'etichetta ci può dire quale commit ha introdotto il problema che viene corretto nella patch::
+
+       Fixes: 1f2e3d4c5b6a ("The first line of the commit specified by the first 12 characters of its SHA-1 ID")
+
+Un'altra etichetta viene usata per fornire collegamenti a pagine web contenenti
+maggiori informazioni, per esempio un rapporto circa il baco risolto dalla
+patch, oppure un documento con le specifiche implementate dalla patch::
+
+       Link: https://example.com/somewhere.html  optional-other-stuff
+
+Alcuni manutentori aggiungono quest'etichetta alla patch per fare riferimento
+alla più recente discussione pubblica. A volte questo è fatto automaticamente da
+alcuni strumenti come b4 or un *hook* git come quello descritto qui
+'Documentation/translations/it_IT/maintainer/configure-git.rst'
+
+Un terzo tipo di etichetta viene usato per indicare chi ha contribuito allo
+sviluppo della patch. Tutte queste etichette seguono il formato::
 
 	tag: Full Name <email address>  optional-other-stuff
 
diff --git a/Documentation/translations/it_IT/process/changes.rst b/Documentation/translations/it_IT/process/changes.rst
index dc7193377b7f..10e0ef9c34b7 100644
--- a/Documentation/translations/it_IT/process/changes.rst
+++ b/Documentation/translations/it_IT/process/changes.rst
@@ -11,8 +11,8 @@ Requisiti minimi per compilare il kernel
 Introduzione
 ============
 
-Questo documento fornisce una lista dei software necessari per eseguire i
-kernel 4.x.
+Questo documento fornisce una lista dei software necessari per eseguire questa
+versione del kernel.
 
 Questo documento è basato sul file "Changes" del kernel 2.0.x e quindi le
 persone che lo scrissero meritano credito (Jared Mauch, Axel Boldt,
@@ -32,12 +32,13 @@ PC Card, per esempio, probabilmente non dovreste preoccuparvi di pcmciautils.
 ====================== =================  ========================================
         Programma       Versione minima       Comando per verificare la versione
 ====================== =================  ========================================
-GNU C                  4.9                gcc --version
-Clang/LLVM (optional)  10.0.1             clang --version
+GNU C                  5.1                gcc --version
+Clang/LLVM (optional)  11.0.0             clang --version
 GNU make               3.81               make --version
 binutils               2.23               ld -v
 flex                   2.5.35             flex --version
 bison                  2.0                bison --version
+pahole                 1.16               pahole --version
 util-linux             2.10o              fdformat --version
 kmod                   13                 depmod -V
 e2fsprogs              1.41.4             e2fsck -V
@@ -58,6 +59,7 @@ iptables               1.4.2              iptables -V
 openssl & libcrypto    1.0.0              openssl version
 bc                     1.06.95            bc --version
 Sphinx\ [#f1]_         1.7                sphinx-build --version
+cpio                   any                cpio --version
 ====================== =================  ========================================
 
 .. [#f1] Sphinx è necessario solo per produrre la documentazione del Kernel
@@ -111,6 +113,16 @@ Bison
 Dalla versione 4.16, il sistema di compilazione, durante l'esecuzione, genera
 un parsificatore.  Questo richiede bison 2.0 o successivo.
 
+pahole
+------
+
+Dalla versione 5.2, quando viene impostato CONFIG_DEBUG_INFO_BTF, il sistema di
+compilazione genera BTF (BPF Type Format) a partire da DWARF per vmlinux. Più
+tardi anche per i moduli. Questo richiede pahole v1.16 o successivo.
+
+A seconda della distribuzione, lo si può trovare nei pacchetti 'dwarves' o
+'pahole'. Oppure lo si può trovare qui: https://fedorapeople.org/~acme/dwarves/.
+
 Perl
 ----
 
@@ -455,6 +467,11 @@ mcelog
 
 - <http://www.mcelog.org/>
 
+cpio
+----
+
+- <https://www.gnu.org/software/cpio/>
+
 Rete
 ****
 
diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index ecc74ba50d3e..a393ee4182af 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -466,14 +466,52 @@ la riga della parentesi graffa di chiusura. Ad esempio:
 	}
 	EXPORT_SYMBOL(system_is_up);
 
+6.1) Prototipi di funzione
+**************************
+
 Nei prototipi di funzione, includete i nomi dei parametri e i loro tipi.
 Nonostante questo non sia richiesto dal linguaggio C, in Linux viene preferito
 perché è un modo semplice per aggiungere informazioni importanti per il
 lettore.
 
-Non usate la parola chiave ``extern`` coi prototipi di funzione perché
+Non usate la parola chiave ``extern`` con le dichiarazioni di funzione perché
 rende le righe più lunghe e non è strettamente necessario.
 
+Quando scrivete i prototipi di funzione mantenete `l'ordine degli elementi <https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com/>`_.
+
+Prendiamo questa dichiarazione di funzione come esempio::
+
+ __init void * __must_check action(enum magic value, size_t size, u8 count,
+                                  char *fmt, ...) __printf(4, 5) __malloc;
+
+L'ordine suggerito per gli elementi di un prototipo di funzione è il seguente:
+
+- classe d'archiviazione (in questo caso ``static __always_inline``. Da notare
+  che ``__always_inline`` è tecnicamente un attributo ma che viene trattato come
+  ``inline``)
+- attributi della classe di archiviazione (in questo caso ``__init``, in altre
+  parole la sezione, ma anche cose tipo ``__cold``)
+- il tipo di ritorno (in questo caso, ``void *``)
+- attributi per il valore di ritorno (in questo caso, ``__must_check``)
+- il nome della funzione (in questo caso, ``action``)
+- i parametri della funzione(in questo caso,
+  ``(enum magic value, size_t size, u8 count, char *fmt, ...)``,
+  da notare che va messo anche il nome del parametro)
+- attributi dei parametri (in questo caso, ``__printf(4, 5)``)
+- attributi per il comportamento della funzione (in questo caso, ``__malloc_``)
+
+Notate che per la **definizione** di una funzione (il altre parole il corpo
+della funzione), il compilatore non permette di usare gli attributi per i
+parametri dopo i parametri. In questi casi, devono essere messi dopo gli
+attributi della classe d'archiviazione (notate che la posizione di
+``__printf(4,5)`` cambia rispetto alla **dichiarazione**)::
+
+ static __always_inline __init __printf(4, 5) void * __must_check action(enum magic value,
+              size_t size, u8 count, char *fmt, ...) __malloc
+ {
+         ...
+ }*)**``)**``)``)``*)``)``)``)``*``)``)``)*)
+
 7) Centralizzare il ritorno delle funzioni
 ------------------------------------------
 
@@ -855,7 +893,7 @@ I messaggi del kernel non devono terminare con un punto fermo.
 Scrivere i numeri fra parentesi (%d) non migliora alcunché e per questo
 dovrebbero essere evitati.
 
-Ci sono alcune macro per la diagnostica in <linux/device.h> che dovreste
+Ci sono alcune macro per la diagnostica in <linux/dev_printk.h> che dovreste
 usare per assicurarvi che i messaggi vengano associati correttamente ai
 dispositivi e ai driver, e che siano etichettati correttamente:  dev_err(),
 dev_warn(), dev_info(), e così via.  Per messaggi che non sono associati ad
diff --git a/Documentation/translations/it_IT/process/deprecated.rst b/Documentation/translations/it_IT/process/deprecated.rst
index 987f45ee1804..febf83897783 100644
--- a/Documentation/translations/it_IT/process/deprecated.rst
+++ b/Documentation/translations/it_IT/process/deprecated.rst
@@ -69,8 +69,8 @@ dovrebbero essere fatto negli argomenti di funzioni di allocazione di memoria
 piccoli di quelli che il chiamante si aspettava. L'uso di questo modo di
 allocare può portare ad un overflow della memoria di heap e altri
 malfunzionamenti. (Si fa eccezione per valori numerici per i quali il
-compilatore può generare avvisi circa un potenziale overflow. Tuttavia usare
-i valori numerici come suggerito di seguito è innocuo).
+compilatore può generare avvisi circa un potenziale overflow. Tuttavia, anche in
+questi casi è preferibile riscrivere il codice come suggerito di seguito).
 
 Per esempio, non usate ``count * size`` come argomento::
 
@@ -80,6 +80,9 @@ Al suo posto, si dovrebbe usare l'allocatore a due argomenti::
 
 	foo = kmalloc_array(count, size, GFP_KERNEL);
 
+Nello specifico, kmalloc() può essere sostituta da kmalloc_array(), e kzalloc()
+da kcalloc().
+
 Se questo tipo di allocatore non è disponibile, allora dovrebbero essere usate
 le funzioni del tipo *saturate-on-overflow*::
 
@@ -100,9 +103,20 @@ Invece, usate la seguente funzione::
 	  invitati a riorganizzare il vostro codice usando il
 	  `flexible array member <#zero-length-and-one-element-arrays>`_.
 
-Per maggiori dettagli fate riferimento a array_size(),
-array3_size(), e struct_size(), così come la famiglia di
-funzioni check_add_overflow() e check_mul_overflow().
+Per altri calcoli, usate le funzioni size_mul(), size_add(), e size_sub(). Per
+esempio, al posto di::
+
+       foo = krealloc(current_size + chunk_size * (count - 3), GFP_KERNEL);
+
+dovreste scrivere:
+
+       foo = krealloc(size_add(current_size,
+                               size_mul(chunk_size,
+                                        size_sub(count, 3))), GFP_KERNEL);
+
+Per maggiori dettagli fate riferimento a array3_size() e flex_array_size(), ma
+anche le funzioni della famiglia check_mul_overflow(), check_add_overflow(),
+check_sub_overflow(), e check_shl_overflow().
 
 simple_strtol(), simple_strtoll(), simple_strtoul(), simple_strtoull()
 ----------------------------------------------------------------------
diff --git a/Documentation/translations/it_IT/process/index.rst b/Documentation/translations/it_IT/process/index.rst
index c4c867132c88..e1cdb3d3c263 100644
--- a/Documentation/translations/it_IT/process/index.rst
+++ b/Documentation/translations/it_IT/process/index.rst
@@ -47,6 +47,7 @@ degli sviluppatori:
    stable-kernel-rules
    submit-checklist
    kernel-docs
+   maintainers
 
 Ed infine, qui ci sono alcune guide più tecniche che son state messe qua solo
 perché non si è trovato un posto migliore.
diff --git a/Documentation/translations/it_IT/process/maintainer-handbooks.rst b/Documentation/translations/it_IT/process/maintainer-handbooks.rst
new file mode 100644
index 000000000000..d840145bcceb
--- /dev/null
+++ b/Documentation/translations/it_IT/process/maintainer-handbooks.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-ita.rst
+
+:Original: Documentation/process/maintainer-handbooks.rst
+:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
+
+.. _it_maintainer_handbooks_main:
+
+Note sul processo di sviluppo dei sottosistemi e dei sorgenti dei manutentori
+=============================================================================
+
+Lo scopo di questo documento è quello di fornire informazioni sul processo di
+sviluppo dedicate ai sottosistemi che vanno ad integrare quelle più generali
+descritte in :ref:`Documentation/translations/it_IT/process
+<it_development_process_main>`.
+
+Indice:
+
+.. toctree::
+   :numbered:
+   :maxdepth: 2
+
+   maintainer-tip
diff --git a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
index f3c8e8d377ee..a1e98ec9532e 100644
--- a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
+++ b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
@@ -931,12 +931,11 @@ che avete nel vostro portachiavi::
     uid           [ unknown] Linus Torvalds <torvalds@kernel.org>
     sub   rsa2048 2011-09-20 [E]
 
-Poi, aprite il `PGP pathfinder`_. Nel campo "From", incollate l'impronta
-digitale della chiave di Linus Torvalds che si vede nell'output qui sopra.
-Nel campo "to", incollate il key-id della chiave sconosciuta che avete
-trovato con ``gpg --search``, e poi verificare il risultato:
-
-- `Finding paths to Linus`_
+Poi, cercate un percorso affidabile da Linux Torvalds alla chiave che avete
+trovato con ``gpg --search`` usando la chiave sconosciuta.Per farlo potete usare
+diversi strumenti come https://github.com/mricon/wotmate,
+https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/tree/graphs, e
+https://the.earth.li/~noodles/pathfind.html.
 
 Se trovate un paio di percorsi affidabili è un buon segno circa la validità
 della chiave. Ora, potete aggiungerla al vostro portachiavi dal keyserver::
@@ -948,6 +947,3 @@ fiducia nell'amministratore del servizio *PGP Pathfinder* sperando che non
 sia malintenzionato (infatti, questo va contro :ref:`it_devs_not_infra`).
 Tuttavia, se mantenete con cura la vostra rete di fiducia sarà un deciso
 miglioramento rispetto alla cieca fiducia nei keyserver.
-
-.. _`PGP pathfinder`: https://pgp.cs.uu.nl/
-.. _`Finding paths to Linus`: https://pgp.cs.uu.nl/paths/79BE3E4300411886/to/C94035C21B4F2AEB.html
diff --git a/Documentation/translations/it_IT/process/maintainer-tip.rst b/Documentation/translations/it_IT/process/maintainer-tip.rst
new file mode 100644
index 000000000000..126f17ee541e
--- /dev/null
+++ b/Documentation/translations/it_IT/process/maintainer-tip.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-ita.rst
+
+:Original: Documentation/process/maintainer-tip.rst
+
+Il tascabile dei sorgenti tip
+=============================
+
+.. note:: To be translated
diff --git a/Documentation/translations/it_IT/process/maintainers.rst b/Documentation/translations/it_IT/process/maintainers.rst
new file mode 100644
index 000000000000..3225f7c89fda
--- /dev/null
+++ b/Documentation/translations/it_IT/process/maintainers.rst
@@ -0,0 +1,13 @@
+:Original: Documentation/process/maintainers.rst
+
+Lista dei manutentori e come inviare modifiche al kernel
+========================================================
+
+Questa pagina non verrà tradotta. Fate riferimento alla versione originale in
+inglese.
+
+.. note:: La pagina originale usa una direttiva speciale per integrare il file
+          `MAINTAINERS` in sphinx. La parte di quel documento che si potrebbe
+          tradurre contiene comunque informazioni già presenti in
+          :ref:`Documentation/translations/it_IT/process/submitting-patches.rst
+          <it_submittingpatches>`.
diff --git a/Documentation/translations/it_IT/process/stable-kernel-rules.rst b/Documentation/translations/it_IT/process/stable-kernel-rules.rst
index 83f48afe48b9..0be675b03199 100644
--- a/Documentation/translations/it_IT/process/stable-kernel-rules.rst
+++ b/Documentation/translations/it_IT/process/stable-kernel-rules.rst
@@ -41,10 +41,10 @@ Regole sul tipo di patch che vengono o non vengono accettate nei sorgenti
 Procedura per sottomettere patch per i sorgenti -stable
 -------------------------------------------------------
 
- - Una patch di sicurezza non dovrebbero essere gestite (solamente) dal processo
-   di revisione -stable, ma dovrebbe seguire le procedure descritte in
-   :ref:`Documentation/translations/it_IT/admin-guide/security-bugs.rst <it_securitybugs>`.
-
+.. note::
+  Una patch di sicurezza non dovrebbe essere gestita (solamente) dal processo
+  di revisione -stable, ma dovrebbe seguire le procedure descritte in
+  :ref:`Documentation/translations/it_IT/admin-guide/security-bugs.rst <it_securitybugs>`.
 
 Per tutte le altre sottomissioni, scegliere una delle seguenti procedure
 ------------------------------------------------------------------------
@@ -90,9 +90,9 @@ L':ref:`it_option_2` e l':ref:`it_option_3` sono più utili quando, al momento
 dell'inclusione dei sorgenti principali, si ritiene che non debbano essere
 incluse anche in quelli stabili (per esempio, perché si crede che si dovrebbero
 fare più verifiche per eventuali regressioni). L':ref:`it_option_3` è
-particolarmente utile se la patch ha bisogno di qualche modifica per essere
-applicata ad un kernel più vecchio (per esempio, perché nel frattempo l'API è
-cambiata).
+particolarmente utile se una patch dev'essere riportata su una versione
+precedente (per esempio la patch richiede modifiche a causa di cambiamenti di
+API).
 
 Notate che per l':ref:`it_option_3`, se la patch è diversa da quella nei
 sorgenti principali (per esempio perché è stato necessario un lavoro di
@@ -167,9 +167,18 @@ Ciclo di una revisione
    della lista linux-kernel obietta la bontà della patch, sollevando problemi
    che i manutentori ed i membri non avevano compreso, allora la patch verrà
    rimossa dalla coda.
- - Alla fine del ciclo di revisione tutte le patch che hanno ricevuto l'ACK
-   verranno aggiunte per il prossimo rilascio -stable, e successivamente
-   questo nuovo rilascio verrà fatto.
+ - Le patch che hanno ricevuto un ACK verranno inviate nuovamente come parte di
+   un rilascio candidato (-rc) al fine di essere verificate dagli sviluppatori e
+   dai testatori.
+ - Solitamente si pubblica solo una -rc, tuttavia se si riscontrano problemi
+   importanti, alcune patch potrebbero essere modificate o essere scartate,
+   oppure nuove patch potrebbero essere messe in coda. Dunque, verranno pubblicate
+   nuove -rc e così via finché non si ritiene che non vi siano più problemi.
+ - Si può rispondere ad una -rc scrivendo sulla lista di discussione un'email
+   con l'etichetta "Tested-by:". Questa etichetta verrà raccolta ed aggiunta al
+   commit rilascio.
+ - Alla fine del ciclo di revisione il nuovo rilascio -stable conterrà tutte le
+   patch che erano in coda e sono state verificate.
  - Le patch di sicurezza verranno accettate nei sorgenti -stable direttamente
    dalla squadra per la sicurezza del kernel, e non passerà per il normale
    ciclo di revisione. Contattate la suddetta squadra per maggiori dettagli
@@ -186,8 +195,19 @@ Sorgenti
  - Il rilascio definitivo, e marchiato, di tutti i kernel stabili può essere
    trovato in rami distinti per versione al seguente indirizzo:
 
-	https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
+	https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
+
+ - I rilasci candidati di tutti i kernel stabili possono essere trovati al
+   seguente indirizzo:
+
+    https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/
+
 
+   .. warning::
+     I sorgenti -stable-rc sono un'istantanea dei sorgenti stable-queue e
+     subirà frequenti modifiche, dunque verrà anche trapiantato spesso.
+     Dovrebbe essere usato solo allo scopo di verifica (per esempio in un
+     sistema di CI)
 
 Comitato per la revisione
 -------------------------
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index 4fb5b3aa306d..65ede4833adc 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -22,12 +22,16 @@ punti da verificare prima di inviare del codice. Se state inviando un driver,
 allora leggete anche
 Documentation/translations/it_IT/process/submitting-drivers.rst; per delle patch
 relative alle associazioni per Device Tree leggete
-Documentation/translations/it_IT/process/submitting-patches.rst.
+Documentation/translations/it_IT/devicetree/bindings/submitting-patches.rst.
 
 Questa documentazione assume che sappiate usare ``git`` per preparare le patch.
 Se non siete pratici di ``git``, allora è bene che lo impariate;
 renderà la vostra vita di sviluppatore del kernel molto più semplice.
 
+I sorgenti di alcuni sottosistemi e manutentori contengono più informazioni
+riguardo al loro modo di lavorare ed aspettative. Consultate
+:ref:`Documentation/translations/it_IT/process/maintainer-handbooks.rst <it_maintainer_handbooks_main>`
+
 Ottenere i sorgenti attuali
 ---------------------------
 
@@ -84,11 +88,11 @@ comporti come descritto.
 
 I manutentori vi saranno grati se scrivete la descrizione della patch in un
 formato che sia compatibile con il gestore dei sorgenti usato dal kernel,
-``git``, come un "commit log".  Leggete :ref:`it_explicit_in_reply_to`.
+``git``, come un "commit log". Leggete :ref:`it_the_canonical_patch_format`.
 
 Risolvete solo un problema per patch.  Se la vostra descrizione inizia ad
 essere lunga, potrebbe essere un segno che la vostra patch necessita d'essere
-divisa. Leggete :ref:`split_changes`.
+divisa. Leggete :ref:`it_split_changes`.
 
 Quando inviate o rinviate una patch o una serie, includete la descrizione
 completa delle modifiche e la loro giustificazione.  Non limitatevi a dire che
@@ -104,17 +108,28 @@ do frotz" piuttosto che "[This patch] makes xyzzy do frotz" or "[I] changed
 xyzzy to do frotz", come se steste dando ordini al codice di cambiare il suo
 comportamento.
 
-Se la patch corregge un baco conosciuto, fare riferimento a quel baco inserendo
-il suo numero o il suo URL.  Se la patch è la conseguenza di una discussione
-su una lista di discussione, allora fornite l'URL all'archivio di quella
-discussione;  usate i collegamenti a https://lore.kernel.org/ con il
-``Message-Id``, in questo modo vi assicurerete che il collegamento non diventi
-invalido nel tempo.
+Se ci sono delle discussioni, o altre informazioni d'interesse, che fanno
+riferimento alla patch, allora aggiungete l'etichetta 'Link:' per farvi
+riferimento. Per esempio, se la vostra patch corregge un baco potete aggiungere
+quest'etichetta per fare riferimento ad un rapporto su una lista di discussione
+o un *bug tracker*. Un altro esempio; potete usare quest'etichetta per far
+riferimento ad una discussione precedentemente avvenuta su una lista di
+discussione, o qualcosa di documentato sul web, da cui poi è nata la patch in
+questione.
+
+Quando volete fare riferimento ad una lista di discussione, preferite il
+servizio d'archiviazione lore.kernel.org. Per create un collegamento URL è
+sufficiente usare il campo ``Message-Id``, presente nell'intestazione del
+messaggio, senza parentesi angolari. Per esempio::
+
+     Link: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
+
+Prima d'inviare il messaggio ricordatevi di verificare che il collegamento così
+creato funzioni e che indirizzi verso il messaggio desiderato.
 
-Tuttavia, cercate di rendere la vostra spiegazione comprensibile anche senza
-far riferimento a fonti esterne.  In aggiunta ai collegamenti a bachi e liste
-di discussione, riassumente i punti più importanti della discussione che hanno
-portato alla creazione della patch.
+Tuttavia, provate comunque a dare una spiegazione comprensibile anche senza
+accedere alle fonti esterne. Inoltre, riassumente i punti più salienti che hanno
+condotto all'invio della patch.
 
 Se volete far riferimento a uno specifico commit, non usate solo
 l'identificativo SHA-1.  Per cortesia, aggiungete anche la breve riga
@@ -226,10 +241,11 @@ nella vostra patch.
 
 Dovreste sempre inviare una copia della patch ai manutentori dei sottosistemi
 interessati dalle modifiche; date un'occhiata al file MAINTAINERS e alla storia
-delle revisioni per scoprire chi si occupa del codice.  Lo script
-scripts/get_maintainer.pl può esservi d'aiuto.  Se non riuscite a trovare un
-manutentore per il sottosistema su cui state lavorando, allora Andrew Morton
-(akpm@linux-foundation.org) sarà la vostra ultima possibilità.
+delle revisioni per scoprire chi si occupa del codice. Lo script
+scripts/get_maintainer.pl può esservi d'aiuto (passategli il percorso alle
+vostre patch). Se non riuscite a trovare un manutentore per il sottosistema su
+cui state lavorando, allora Andrew Morton (akpm@linux-foundation.org) sarà la
+vostra ultima possibilità.
 
 Normalmente, dovreste anche scegliere una lista di discussione a cui inviare la
 vostra serie di patch. La lista di discussione linux-kernel@vger.kernel.org
@@ -324,14 +340,19 @@ cosa stia accadendo.
 
 Assicuratevi di dire ai revisori quali cambiamenti state facendo e di
 ringraziarli per il loro tempo.  Revisionare codice è un lavoro faticoso e che
-richiede molto tempo, e a volte i revisori diventano burberi.  Tuttavia, anche
-in questo caso, rispondete con educazione e concentratevi sul problema che
-hanno evidenziato.
+richiede molto tempo, e a volte i revisori diventano burberi. Tuttavia, anche in
+questo caso, rispondete con educazione e concentratevi sul problema che hanno
+evidenziato. Quando inviate una version successiva ricordatevi di aggiungere un
+``patch changelog`` alla email di intestazione o ad ogni singola patch spiegando
+le differenze rispetto a sottomissioni precedenti (vedere
+:ref:`it_the_canonical_patch_format`).
 
 Leggete Documentation/translations/it_IT/process/email-clients.rst per
 le raccomandazioni sui programmi di posta elettronica e l'etichetta da usare
 sulle liste di discussione.
 
+.. _it_resend_reminders:
+
 Non scoraggiatevi - o impazientitevi
 ------------------------------------
 
@@ -504,7 +525,8 @@ Utilizzare Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: e Fixes:
 L'etichetta Reported-by da credito alle persone che trovano e riportano i bachi
 e si spera che questo possa ispirarli ad aiutarci nuovamente in futuro.
 Rammentate che se il baco è stato riportato in privato, dovrete chiedere il
-permesso prima di poter utilizzare l'etichetta Reported-by.
+permesso prima di poter utilizzare l'etichetta Reported-by. Questa etichetta va
+usata per i bachi, dunque non usatela per richieste di nuove funzionalità.
 
 L'etichetta Tested-by: indica che la patch è stata verificata con successo
 (su un qualche sistema) dalla persona citata.  Questa etichetta informa i
@@ -574,6 +596,8 @@ previste per i kernel stabili, e nemmeno dalla necessità di aggiungere
 in copia conoscenza stable@vger.kernel.org su tutte le patch per
 suddetti kernel.
 
+.. _it_the_canonical_patch_format:
+
 Il formato canonico delle patch
 -------------------------------
 
@@ -719,6 +743,8 @@ messe correttamente oltre la riga.::
 
 Maggiori dettagli sul formato delle patch nei riferimenti qui di seguito.
 
+.. _it_backtraces:
+
 Aggiungere i *backtrace* nei messaggi di commit
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-- 
2.32.0.93.g670b81a890


